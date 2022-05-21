---
categories:
- Notes
date: '2020-04-29T18:52:32+08:00'
title: 为WSL配置SOCKS5代理
---

因为一些众所周知的原因，在国内使用 pip 等网络服务的时候会很麻烦，即使换了源有时候速度也不理想，这种时候就会希望使用代理；但 WSL 并不能直接使用 Windows 上的代理软件，需要进行一些配置。

<!--more-->

## 配置 Windows 本地代理软件

首先最重要的一步：**Windows 上的代理软件需要允许来自 LAN 的连接**

以 V2rayN 为例：

![](https://cdn.jsdelivr.net/gh/panelatta/static-resources/img/DWgMcGLtrhjI6PO.png)

## 安装并使用 `polipo`

在 WSL 上安装 `polipo`：（这里以 Ubuntu 为例）

```bash
sudo apt install polipo
```

之后编辑配置文件 `sudo vim /etc/polipo/config`，在文件末尾添加内容如下：

```
socksParentProxy = "localhost:1080"
socksProxyType = socks5
proxyPort = 8123
```

其中

- `socksParentProxy` 是 Windows 上代理软件设置的代理地址和端口号

- `socksProxyType` 是 `socks` 类型，通常都是 `socks5`

- `proxyPort` 是 WSL 上的代理端口地址

保存后重启 `polipo` 服务即可。

```bash
service polipo stop 
service polipo start 
```

之后配置登入 WSL 终端后，自动开启代理：

新建文件 `sudo vim /usr/local/sbin/polipo.sh`，添加如下内容

```
#!/bin/bash  
export http_proxy=http://localhost:8123
```

这里 `8123` 修改成上面你在 `proxyPort` 里填写的端口号，之后保存退出。

编辑 `~/.bashrc` 文件，在末尾添加

```
source /usr/local/sbin/polipo.sh
```

保存退出后重启 Shell 即可。可以用 `curl www.google.com` 测试代理是否开启。
