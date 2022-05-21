---
author: Panelatta
categories:
- Computer Science
- Visual Tracking
cid: 256
date: '2019-11-02T22:25:00+08:00'
layout: post
mathjax: true
status: publish
tags: null
title: Tracking Holistic Object Representations 论文笔记
updated: 2019-11-02 22:37:39
---

## 问题动机

当前前沿的 tracker 大多基于 template matching 方法，但大多 tracker 在同一时间只使用目标的单张 template，其 updating 过程始终基于当前目标仍与原始 template 有较高相似度的假设，因而在目标发生较大形态变化时便会丢失目标，如图所示：

![1571494440051.png](https://i.loli.net/2019/11/02/djzMgP1lQBDbGfn.png)

<!--more-->

## 主要贡献

1. 以 Multi-template module 为基础，使用长短期特征结合的方式进行跟踪，较好地解决了传统 single-template tracker 在 updating 过程中的漂移问题。
2. 可以很容易地用于其他 tracker 而不需特别训练，在 accuracy 和 robustness 均有提升的情况下速度几乎没有降低。



## 解决思路

![1571495463047.png](https://i.loli.net/2019/11/02/Lzq72AOjGx59fIC.png)

为了获得关于目标动态变化的较好表达，作者提出了一种基于 STM(short-term module) 和 LTM(long-term module) 构成的 multi-template 框架，如上图所示。其中，STM 和 LTM 分别用于描述模板的短期更新和目标在较长一段时间内的外观变化。

对每帧模板 $T_i$，由 Siamese Network 从中提取特征$f_i$ ，之后用当前获取的所有特征构建 Gram 矩阵：
$$
G(f_1, \cdots, f_n) = \begin{bmatrix}f_1 \star f_1 & f_1 \star f_2 & \cdots & f_1 \star f_n \\\vdots	& \vdots & \ddots & \vdots \\f_n \star f_1 & f_n \star f_2 & \cdots & f_n \star f_n\end{bmatrix}
$$

>Gram 矩阵对两两特征间进行卷积运算，用于表示其间相关性和不同特征分别在图像中出现的量，在图像风格迁移 [(Justin Johnson etc., ECCV 2016)](https://arxiv.org/abs/1603.08155) 中引入用于表示图像的整体风格。

其中 $G$是一个 $n \times n$ 矩阵，且通常$n$ 比特征空间的维度要小。

LTM 的目的是维护一个关于当前目标的最具多样性的模板的集合，因而从当前获取的特征中选取一定数量的最具多样性的特征，以最大化由特征向量 $\{f_1, f_2, \cdots, f_n\}$构成的平行多面体的体积 $\Gamma(f_1, f_2, \cdots, f_n)$；而 $G$的行列式（即$|G|$）为$\{f_1, f_2, \cdots, f_n\}$ 构成的平行多面体的体积之平方。因此目标函数为
$$
\max_{f_1, f_2, \cdots, f_n} \Gamma(f_1, \cdots, f_n) \propto \max_{f_1, f_2, \cdots, f_n}|G(f_1, f_2, \cdots, f_n)|
$$
LTM 的更新方法为：当某个模板可增大 $|G|$ 时，说明其更具多样性，此时用其替换 LTM 集合中的对应模板。同时，为了避免 漂移问题，作者为更新过程设置了 lower bound，新的模板需要满足如下条件：
$$
f_c \star f_1 > \ell \cdot G_{11} - \gamma
$$
同时，对于 abrupt movements 和 partial occlusion，此时模板与原始模板相似度过低，LTM 在这种情况下不适用；因此类似传统 tracker，作者设置了 STM 模块来维护当前所在帧附近一段短期时间中的时序信息。STM 采用 FIFO 的方式更新模板，并构建对应的 Gram 矩阵 $G_{st}$。但通过 Gram 行列式的值进行计算的方法在 STM 上表现并不好，因此作者采用以下方式度量 diversity
$$
\gamma = 1 - \frac{2}{N(N+1)G_{st,max}}\sum_{i<j}^N G_{st,ij}
$$
其中 $\gamma \in [0,1]$，且当 $\gamma$越靠近$1$ 时，说明 STM 中模板 diversity 程度越高。

在实际跟踪过程中，出于应对短期变化的考虑，大部分情况下使用 STM 特征；当发生模板漂移时，选择使用 LTM 特征，同时重新初始化 STM 特征。



## 实验

![1571499052017.png](https://i.loli.net/2019/11/02/9MnS5DqUPyxs21g.png)

可以看到应用 THOR 方法后，跟踪器的 robustness 提升显著，但在 VOT 和 OTB 数据集中 accuracy 的表现差异较大，OTB 的情况下有不错提升但 VOT 中没什么效果，推测是因为加入颜色特征后目标发生剧烈变化时与 origin template 差别太大导致 LTM 大部分情况下没起作用，大部分时候仍使用 STM 特征，而 OTB 的灰度特征因为只主要与目标的外形变化有关因而 LTM 特征可以顺利得以应用。此外，THOR 的这个情况和 CSR-DCF 的情况刚好相反，比较有意思。
