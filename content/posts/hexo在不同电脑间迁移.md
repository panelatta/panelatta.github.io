---
author: Panelatta
categories:
- Notes
cid: 64
date: '2018-05-21T19:17:00+08:00'
layout: post
mathjax: true
status: publish
tags:
- hexo
thumb: null
thumbStyle: small
title: hexo在不同电脑间迁移
updated: 2018-06-10 20:24:28
viewsNum: 233
---

hexo部署到github上的文件是你本地的文件（.md）编译成的静态网页（.html），因此当你想要在不同设备间修改博客，或者是重装系统导致博客配置丢失后修改博客就变成了比较麻烦的事情。

其实，hexo生成的网站文件中有`.gitignore`文件，所以它的本意也是让你把博客的源文件上传到github上进行管理。今天我们就介绍一种方法，这种方法通过**在博客挂在的github仓库中设立一个新的分支hexo，然后将博客源文件以及环境配置和主题配置文件上传到hexo分支（设置为默认主分支），将master分支用作进行博文的deploy工作，这样每次需要重新配置时只需要重新clone一下，之后安装相关环境就可以了。**


<!--more-->


>1. 建立master和hexo两个分支
>2. 安装相关环境和本地配置
>   1. git clone
>   2. 备份更新`./themes`主题配置文件
>   3. 安装hexo
>3. 博客的日常更新

## 建立master和hexo两个分支

master分支已经是默认建好的，我们只需修改`_config.yml`中的deploy分支为master，之后用`hexo d`命令就会自动将我们的文件编译成静态网页后部署到github。

之后我们再新建一个hexo分支，并设置为默认主分支，之后将所有的博客源文件都copy到选定目录中。同时，由于hexo中`.gitignore`文件设置了忽略，因此我们需要再新建一个`settings`文件夹，将`./themes`中对应的主题配置文件copy到其中进行备份更新。之后手动`git push`即可。

## 安装相关环境和本地配置

### git clone

先从网上下载Node.js和git，之后使用

`git clone git@github.com:<yourname>/<yourname>.github.io`

拷贝仓库。

### 备份更新`./themes`主题文件

执行如下命令：

` cp -rf ./settings/next ./themes `

### 安装hexo

执行如下命令：

`npm install hexo`

`npm install`

`npm install hexo-deployer-git`

并且千万不要执行`hexo init`，这样会使已经配置好的文件丢失。

## 博客的日常更新

依次执行

`git add .`

`git commit -m "..."`

`git push origin hexo`

将改动推送到github上。之后再执行`hexo g -d`来发布网站。
