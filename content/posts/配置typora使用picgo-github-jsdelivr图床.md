---
categories:
- Notes
date: '2020-07-21T22:48:34+08:00'
tags:
- Typora
title: 配置typora使用picgo+github+jsdelivr图床
toc: true
---

之前 Typora 一直不支持图床功能，在本地写博客时只能事先把图片手动传到 sm.ms 等图床再复制到文章内，十分不方便；Typora 在 `0.9.84` 版本增加了使用 PicGo 将图片上传到图床的功能，可以直接将图片上传到 Github 图床，配合免费的 JsDelivr CDN 可以有效加快 Github 上静态资源的加载速度，大大方便了博客的编写。

<!--more-->

## Github 上的配置

### 创建 Github 仓库

在 Github 上创建一个公开仓库，用于存放我们的静态文件，这里不再赘述。

### 获取 token

在 Github 上，依次进入 Settings → Developer settings → Personal access tokens，选择 Generate new token：

![](https://cdn.jsdelivr.net/gh/panelatta/static-resources/img/image-20200722005811808.png)

之后在 Note 处填写 token 的名字，并将 Select scopes 中的 repo 勾选上即可。

![](https://cdn.jsdelivr.net/gh/panelatta/static-resources/img/image-20200722010310196.png)

之后点击 Generate token 并记下生成的 token。（很重要，因为这段 token 只会展示一次）

## 安装并配置 PicGo-core

### 下载 PicGo-core

确保你已经安装 Node.js，在命令行内执行 `npm install picgo -g`

### 设置 PicGo-core

在命令行内执行 `picgo set uploader`，之后会显示如下内容：

```
? Choose a(n) uploader (Use arrow keys)
  smms
  tcyun
> github
  qiniu
  imgur
  aliyun
  upyun
```

使用光标键选择 `github`，之后对每个设置项按如下方式填入：

```
? repo: <username>/<repo>
? branch: master
? token: <token>
? path: img/
? customUrl: https://cdn.jsdelivr.net/gh/<username>/<repo>
```

逐项解释：

- `repo`：按照 `<username>/<repo>` 的格式填入你刚刚创建的公开仓库，如 `panelatta/static-resources`
- `branch`：你在 `repo` 内使用的 branch，默认 `master`
- `token`：你刚刚申请的 token
- `path`：你在 repo 内用于上传文件的目录，随意填写即可，这里使用 `img/`
- `customUrl`：你的自定义域名，PicGo 上传图片后将会直接返回此处的自定义域名 + `path` 组合成的网址，这里设置为 JsDelivr CDN 的地址

之后打开`~/.picgo/config.json`，按图中所示进行修改：

![image-20200823214910498](https://cdn.jsdelivr.net/gh/panelatta/static-resources/img/image-20200823214910498.png)

之所以进行此项修改的原因是 picgo 可能默认将此项设置置为 `smms`。

## 配置 Typora

在 Typora 的偏好设置→图像中，如图所示进行设置：

![](https://cdn.jsdelivr.net/gh/panelatta/static-resources/img/image-20200722192738104.png)

在 `插入图片时...` 处：

- 选择 `上传图片`
- 勾选 `对本地位置的图片应用上述规则`，这一项勾选后会将本地位置/剪贴板内的图片上传至图床
- 勾选 `对网络位置的图片应用上述规则`，这一项勾选后会将网络图片上传至图床

在 `上传服务设定` 处：

- `上传服务` 选择 `Custom Command`

  > **Note:** 这里也可选择 `PicGo-core` 项，就不需要再手动配置下面的 `自定义命令` 了，但我试了没成功

- `自定义命令`  处填入 `picgo upload`

之后点击 `验证图片上传选项`，验证图片上传成功即可。

## 需要注意的点

- 当一张图片已经上传至图床后，不要再次尝试将同名图片重新上传，否则会造成上传失败
