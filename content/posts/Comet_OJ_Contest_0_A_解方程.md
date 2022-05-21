---
author: Panelatta
categories:
- Programming Contest
- ACM
cid: 153
date: '2019-04-06T16:31:00+08:00'
layout: post
mathjax: true
status: publish
tags:
- ACM题解
thumb: null
thumbSmall: null
thumbStyle: small
title: 'A. 解方程 (暴力) [Comet OJ Contest #0]'
updated: 2019-08-16 15:48:53
viewsNum: 376
---

<!--more-->

## 题面

### Description

小象同学在初等教育时期遇到了一个复杂的数学题，题目是这样的：给定自然数 $n$，确定关于$x,y,z$ 的不定方程

$\sqrt{x-\sqrt{n}} + \sqrt{y} - \sqrt{z}=0$ 的解。                                                                                                                                                                                                                                                                                   

当时的小象同学并不会做这道题。多年后，经过高等教育的洗礼，小象同学发现这道题其实很简单。小象同学认为你一定也会做这道题，所以把这道题留给了你。为了便于输出，你不需要输出每一组解 $(x,y,z)$，你只需要给出解的数量和所有解的 $xyz$之和对$(10^{9}+7)$ 取模的值即可。注意，解的数量不对$10^{9}+7$ 取模。

### Input

输入包含多组测试数据。输入的第一行包含一个正整数 $T\;(1 \leq T \leq 10^{4})$ ，表示测试数据的组数。接下来依次描述每组测试数据，对于每组测试数据：

仅一行，包含一个非负整数 $n\;(0\leq n \leq 2 \times 10^{9})$ ，含义如题面所示。

### Output

对于每组数据，输出一行。若方程有无穷多组自然数解，则在这一行输出 $\text{‘‘infty''}$（不含引号），否则在这一行输出两个整数，其中第一个整数表示方程的解数，第二个整数  表示所有解的 $xyz$之和对$(10^{9}+7)$ 取模的值，这两个整数之间用恰好一个空格隔开，行末不要有多余的空格。

### Sample Input

```
3
6
12
24
```

### Sample Output

```
0 0
1 12
2 72
```

### Hint

当 $n=12$时，方程唯一的解为$x=4,y=1,z=3$ 。

当 $n=24$时，方程的两组解为 $x=5,y=2,z=3$ 和$x=7,y=1,z=6$ 。

## 题解

首先注意到显然当且仅当 $n=0$或 $n$为完全平方数时，给定方程有无穷多组解，通解为$(\sqrt{n},c,c)$ ，其中$c$ 是任意自然数。

现在，考察何时方程有有限多组解。将所给方程做如下变换
$$
\sqrt{x-\sqrt{n}}=\sqrt{z}-\sqrt{y}
$$
两边平方得
$$
x-\sqrt{n}=y+z-2\sqrt{yz}
$$
移项得
$$
x-(y+z)=\sqrt{n}-2\sqrt{yz}
$$
此时，考虑两种情况：

- 方程左右两边均为 $0$ 

此时，显然有
$$
\left \{ \begin{matrix} x=y+z \\ n = 4yz \end{matrix} \right.
$$

- 方程左右两边均不为 $0$ 

因为 $x,y,z\in \mathbb{N} $，故 $x-(y+z) \in \mathbb{Z}$，故应当也有 $\sqrt{n}-2\sqrt{yz} \in \mathbb{Z}$。若 $n \neq 4yz$，则当且仅当 $n$与 $yz$均为 $0$或完全平方数（但不同时为$0$）时，满足该条件；这是不可能的。因为，若$n$或$yz$ 为$0$ 时，必有$n=yz=0$；若$n$ 或$yz$ 均不为$0$ ，则$n$ 必须为完全平方数，此时方程有无穷多组解。

综上，当且仅当 $\left \{ \begin{matrix} x=y+z \\ n=4yz \end{matrix} \right.$ 成立时，方程有有限多组解。

此时注意到当且仅当 $n$是 $4$的倍数时，方程有解；又注意到 $n \leq 2 \times 10^{9}$，因此遍历$[1, \sqrt{n}]$ 寻找$n$ 的因子即可。时间复杂度$O(\sqrt{n})$ 。

**注意此题**`long long`**会超时**

### 代码

```
#include <bits/stdc++.h>
using namespace std;

const int MODULO = 1e9 + 7;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(0);

    int t = 0;
    cin >> t;

    while (t--) {
        int n = 0;
        cin >> n;

        if (n == 0 || (int)sqrt((double)n) * (int)sqrt((double)n) == n) {
            cout << "infty" << endl;
            continue;
        }

        if (n % 4) {
            cout << 0 << " " << 0 << endl;
            continue;
        }

        n /= 4;
        int m = (int)sqrt((double)n + 0.5);

        int ans = 0, num = 0;
        for (int i = 1; i <= m; i++) {
            if (n % i)
                continue;

            num++;

            int z = n / i;
            int x = ((long long)i + z) % MODULO;
            ans   = ((long long)ans + (long long)x * n % MODULO) % MODULO;
        }

        cout << num << " " << ans << endl;
    }

    return 0;
}
```
