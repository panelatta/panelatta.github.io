---
categories:
- Notes
date: '2021-03-03T15:33:21+08:00'
tags:
- Git
- Git 分支
- Git 远程
title: git clone拉取指定分支代码到本地
toc: true
---

`git clone` 默认只能拉取 `master` 分支的代码，但很多时候需要拉取其他分支的代码，本文列出了两种方式。

<!--more-->

## `git clone` 的同时拉取指定分支

使用命令 `git clone -b <branch> <仓库地址>`

## 拉取本地已有仓库的指定分支

1. `git fetch origin <branch>`  将远程 `<branch>` 分支拉到本地

   > `git fetch` 命令用于从另一个存储库下载对象和引用：
   >
   > - 要更新所有分支，可将命令简写为 `git fetch`
   > - 要更新指定分支，需指定分支名 `git fetch <remote_host> <branch>`

2. `git checkout -b dev origin/<branch>` 在本地创建 `dev` 分支并切换到该分支

   > `origin/<branch>` 指将本地 Git 的头指针指向 `origin` 库的 `<branch>` 分支

3. `git pull origin <branch>` 将远程 `<branch>` 分支上的内容全部拉取至本地

   > 当本地代码是 `dev` 分支时，需要先 `git pull origin <branch>` 更新远程分支代码到本地，之后再 `git pull` 拉取远程 `master` 分支到本地，否则会引起冲突

## References

- https://www.jianshu.com/p/d87da5cdd46e
- https://www.cnblogs.com/woyaobianfei/p/9176062.html
