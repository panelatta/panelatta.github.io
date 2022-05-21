---
categories:
- Notes
date: '2020-04-26T16:38:54+08:00'
title: 用Steam Desktop Authenticator获取Steam Guard的TOTP种子
toc: true
---

`KeeTrayTOTP` 这个 KeePass 插件支持生成 Steam Guard 的安全验证码，但是 Steam 出于安全原因并没有提供导出 TOTP 种子的选项；网上现有的方法需要用到已 root 的安卓机，这里提供一种方法，可以在 PC 上直接获取 TOTP 种子，继而导入进 KeePass 里。

**注意：这个方法会重新绑定 Steam Guard 设备，会使得已有设备上开启的 Steam Guard 失效，如果你仍想保留已有设备上的 Steam Guard ，请勿使用该方法。**

<!--more-->

## 安装 Steam Desktop Authenticator

从官方的 Github 仓库下载最新的 [Steam Desktop Authenticator](https://github.com/Jessecar96/SteamDesktopAuthenticator/releases)，并按照官方教程配置，但注意在这一步不要输入 encryption key，否则存储 TOTP 信息的文件会被加密：

![](https://i.loli.net/2020/04/26/KJTMbls9p7HyAWj.png)

之后无视提醒即可

![](https://i.loli.net/2020/04/26/A42LEHgur5xvzqw.png)

之后在 Steam Desktop Authenticator 所在目录下找到 `maFiles` 目录，里面以 `.maFile` 为后缀名的文件就是存储了密钥信息的数据文件。在其中找到这一行：

```
"uri":"otpauth://totp/Steam:[your_Steam_login]?secret=[TOTP_secret]&issuer=Steam"
```

将 `[TOTP_secret]` 导入 KeePass 即可，注意不要再重新在其他设备上重新绑定 Steam Guard，否则会使提取的 TOTP 种子失效。

## 如果前面输入了 encryption key 怎么办

打开 `maFiles` 目录里的 `manifest.json` 并记录以下信息：

```
"encryption_iv":"[string]"
"encryption_salt":"[string]"
```

之后在同一目录下创建两个 Python 脚本 `pkcs7.py` 和 `stm.py`，内容分别为：

### `pkcs7.py` 

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-

from Crypto.Cipher import AES

import binascii
from io import StringIO

class PKCS7Encoder(object):
    '''
    RFC 2315: PKCS#7 page 21
    Some content-encryption algorithms assume the
    input length is a multiple of k octets, where k > 1, and
    let the application define a method for handling inputs
    whose lengths are not a multiple of k octets. For such
    algorithms, the method shall be to pad the input at the
    trailing end with k - (l mod k) octets all having value k -
    (l mod k), where l is the length of the input. In other
    words, the input is padded at the trailing end with one of
    the following strings:

             01 -- if l mod k = k-1
            02 02 -- if l mod k = k-2
                        .
                        .
                        .
          k k ... k k -- if l mod k = 0

    The padding can be removed unambiguously since all input is
    padded and no padding string is a suffix of another. This
    padding method is well-defined if and only if k < 256;
    methods for larger k are an open issue for further study.
    '''
    def __init__(self, k=16):
        self.k = k

    ## @param text The padded text for which the padding is to be removed.
    # @exception ValueError Raised when the input padding is missing or corrupt.
    def decode(self, text):
        '''
        Remove the PKCS#7 padding from a text string
        '''
        nl = len(text)
        val = int(binascii.hexlify(text[-1]), 16)

        if val > self.k:
            raise ValueError('Input is not padded or padding is corrupt')

        l = nl - val

        return text[:l]

    ## @param text The text to encode.
    def encode(self, text):
        '''
        Pad an input string according to PKCS#7
        '''
        l = len(text)
        output = StringIO()
        val = self.k - (l % self.k)

        for _ in range(val):
            output.write('%02x' % val)

        return text + binascii.unhexlify(output.getvalue())
```

### `stm.py`

此处需要手动填入四个值：

前面记录的 `encryption_iv` 和 `encryption_salt` 分别填入 `iv` 和 `salt` 中；

将以 `.maFile` 结尾的数据文件（此时已被加密）全文整个字符串填入 `maFile` 中；

将前面你填入的 encryption key 填入 `passwd` 中

```python
import base64
from pbkdf2 import PBKDF2
from Crypto.Cipher import AES
from pkcs7 import PKCS7Encoder

iv = ''
salt = ''
mafile = ''

getb64str = lambda x : str(base64.b64decode(x), encoding="utf-8")
iv = base64.b64decode(iv)
salt = base64.b64decode(salt)
cipher = base64.b64decode(mafile)
passwd = ''

PBKDF2_ITERATIONS = 50000
KEY_SIZE_BYTES = 32

encoder = PKCS7Encoder()
key = PBKDF2(passwd, salt, iterations=PBKDF2_ITERATIONS).read(KEY_SIZE_BYTES)
decryptor = AES.new(key, AES.MODE_CBC, iv)
plain = decryptor.decrypt(cipher)
print(plain)
```

之后手动运行 `python ./stm.py` 即可解密。
