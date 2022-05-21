---
categories:
- Notes
date: '2021-05-03T02:23:30+08:00'
tags:
- Ubuntu
- Tricks
title: 更新Ubuntu默认终端为Terminator
toc: true
---

最近安装了 Terminator 替换 Ubuntu 的原生终端，美中不足的是按 Ctrl + Alt + T 快捷键时默认启动的还是原生终端。下面介绍一下怎么更改按下 Ctrl + Alt + T 快捷键时唤起的终端。

<!--more-->

## 命令

使用如下命令即可：

```bash
gsettings set org.gnome.desktop.default-applications.terminal exec /usr/bin/terminator
gsettings set org.gnome.desktop.default-applications.terminal exec-arg "-x"
```

当想换回默认设置时：

```bash
gsettings reset org.gnome.desktop.default-applications.terminal
```

> 参考资料：[Ubuntu用Terminator+ZSH打造好用的终端开发环境](https://zhuanlan.zhihu.com/p/346665734)

## 无效命令

针对这一问题，网上的大部分资料给出的是使用 `update-alternatives` 的解决方案：

```bash
sudo update-alternatives --config x-terminal-emulator
```

但这一命令在我的电脑上无效。

> 参考资料：[如何在 Ubuntu 中更改默认终端](https://zhuanlan.zhihu.com/p/107582337)
