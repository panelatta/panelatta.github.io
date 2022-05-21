---
author: Panelatta
categories:
- Programming Contest
cid: 46
date: '2018-06-07T21:50:00+08:00'
layout: post
mathjax: true
status: publish
tags:
- ACM解题总结
thumb: null
thumbSmall: null
thumbStyle: large
title: ACM Trick Points (持续更新)
updated: 2019-08-16 15:39:50
viewsNum: 710
---

<!--more-->

## 函数

###  memset 赋值

我们在设计程序时经常会使用`memset(array, val, sizeof(array))`来初始化一个`int`数组`array`，因为`memset`是`string.h`中的函数所以其填充对象也是字节，会将数值`val`（或者是字符`val`）填充到`array`的每个字节上，因此用`memset`只能赋值出每字节都相同的`int`。

因此，我们如果想要将某个数组初始化为`INF`，则能赋值出的最大数值为`0x7fffffff`。但是为了避免加法算术溢出或其他判断，我们通常选择将数组的每个`int`初始化为`0x3f3f3f3f`。这个数值满足以下两个条件：

1. 整数的两倍不超过`0x7fffffff`（即`INT_MAX`）。
2. 整数的每8位都相同（恰好可以用`memset`填充）。

因此我们通常使用`memset(array, 0x3f, sizeof(array))`来初始化int数组。

###  scanf 读取数组元素

输入括号需要来回切换光标，十分麻烦...如果不想输入类似`&a[i]`的符号，可以使用指针形式来简化输入: `scanf("%d", a + i);`

这个方法也适合在读入字符串时将其存储在并非数组开头的位置。

## 数学

### 余式定理

对多项式$P(x) $，有$\frac{P(x)}{x-a}$之余式为$ P(a)$。

更一般地，假设对于多项式除法$\frac{P(x)}{M(x)}=Q(x)+R(x) $，其中商是$Q(x) $，余式是$R(x) $，若$ M(x)$是n次式$ (n \geq 1)$，则可将其$ n$个根列出联立方程

$$\\P(a)=R(a) \\P(b)=R(b) \\P(c)=R(c) \\ \cdots$$

#### 证明

考虑$\frac{P(x)}{x-a}=Q(x)+R(x)$。

由除法定理有$P(x)=(x-a)Q(x)+R(x) $。且因为$x-a $是1次式，故$ R(x)$为常数，记为$ r$。

此时代入$x=a $，可得$ P(a)=r$。证毕。

## Attention Points

### 运算符优先级

一些运算符的优先级由高到低如下表所示，最需要注意的点是：大小关系比较运算符的优先级高于“位与”“位或”“位非”运算符。

| 加减 |  移位  |   比较大小   | 位与 | 异或 | 位或 |
| :--: | :----: | :----------: | :--: | :--: | :--: |
| +, - | <<, >> | >, <, ==, != |  &   |  ^   | 位或 |

###  vector 的 push_back 相关

在没有显式为某个`vector`分配空间时，绝不能用下标访问其元素而应使用`push_back`。

## 阴险的出数据方式

#### POJ 3263

一条关系$ (A_{i}, B_{i})$ 可能会输入多次（即输入重边），刻意影响区间操作。
