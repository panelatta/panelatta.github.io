---
categories:
- Computer Science
- Visual Tracking
date: '2020-08-24T14:23:21+08:00'
tags:
- CSR-DCF
- 论文笔记
title: Discriminative Correlation Filter Tracker with Channel and Spatial Reliability
  (CSR-DCF) 论文笔记
---

最近开始看 CSR-DCF 这篇论文，有一些公式推导及不懂的地方记在此处。

<!--more-->

## 公式推导

### 公式 (3) 的推导

> ${\bf N{\scriptsize OTE}}.$ 
>
> 原公式中后半部分的 $\lambda\sum\limits_{d=1}^{N_c}\left\|{\bf \hat{h}}\right\|_2^2$  似不正确，以下都修正为 $\lambda\sum\limits_{d=1}^{N_c}\left\|{\bf \hat{h}_d}\right\|_2^2$。但修正后的结果与公式(5)冲突（公式(5)相对(3)的唯一区别只在此处，若进行此修正，则公式(5)无单独列出的意义；但不进行此修正，则无法推导(3)得出结果(4)。

原公式为

![](https://cdn.jsdelivr.net/gh/panelatta/static-resources/img/UbY4a7aENy.svg)

对 $\hat{\bf h}_d$ 进行求导：

![](https://cdn.jsdelivr.net/gh/panelatta/static-resources/img/2G5Hbazmf7.svg)

分别对两部分进行求导：

令 ${\bf c} = \sum\limits_{d=1}^{N_c}\hat{\bf f}_d \odot \overline{\hat {\bf h}}_d - \hat {\bf g}$，则

![](https://cdn.jsdelivr.net/gh/panelatta/static-resources/img/JBJI0F6Z2w.svg)

又

![](https://cdn.jsdelivr.net/gh/panelatta/static-resources/img/sDg58hKWXf.svg)

因此

![](https://cdn.jsdelivr.net/gh/panelatta/static-resources/img/lMt7QhPSzC.svg)

故

![](https://cdn.jsdelivr.net/gh/panelatta/static-resources/img/eWI32NtRmt.svg)

又

![](https://cdn.jsdelivr.net/gh/panelatta/static-resources/img/fVe4p2eNvu.svg)

因此

![](https://cdn.jsdelivr.net/gh/panelatta/static-resources/img/k2VGrl06f6.svg)

故

![](https://cdn.jsdelivr.net/gh/panelatta/static-resources/img/wMpfYshNp1.svg)

令 $\dfrac{\partial\epsilon}{\partial\overline{\hat{\bf h}}_d} = 0$，解得

![](https://cdn.jsdelivr.net/gh/panelatta/static-resources/img/9fwhOT0q2l.svg)

>${\bf N{\scriptsize OTE}}.$
>
>最后的 $\lambda$ 应向量化作 $\lambda {\bf \vec1}$。
