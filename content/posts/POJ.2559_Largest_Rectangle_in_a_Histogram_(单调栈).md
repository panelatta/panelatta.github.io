---
author: Panelatta
categories:
- Programming Contest
- ACM
- POJ
cid: 120
date: '2018-09-04T22:36:00+08:00'
layout: post
mathjax: true
status: publish
tags:
- ACM题解
thumb: null
thumbStyle: small
title: POJ.2559 Largest Rectangle in a Histogram (单调栈)
updated: 2019-08-16 15:54:57
viewsNum: 224
---

<!--more-->

## 题面

### Description

A histogram is a polygon composed of a sequence of rectangles aligned at a common base line. The rectangles have equal widths but may have different heights. For example, the figure on the left shows the histogram that consists of rectangles with the heights 2, 1, 4, 5, 1, 3, 3, measured in units where 1 is the width of the rectangles: 

![](http://media.openjudge.cn/images/g1561/2559_1.jpg)

Usually, histograms are used to represent discrete distributions, e.g., the frequencies of characters in texts. Note that the order of the rectangles, i.e., their heights, is important. Calculate the area of the largest rectangle in a histogram that is aligned at the common base line, too. The figure on the right shows the largest aligned rectangle for the depicted histogram.

### Input

The input contains several test cases. Each test case describes a histogram and starts with an integer *n*, denoting the number of rectangles it is composed of. You may assume that *1<=n<=100000*. Then follow *n* integers *h1,...,hn*, where *0<=hi<=1000000000*. These numbers denote the heights of the rectangles of the histogram in left-to-right order. The width of each rectangle is *1*. A zero follows the input for the last test case.

### Output

For each test case output on a single line the area of the largest rectangle in the specified histogram. Remember that this rectangle must be aligned at the common base line.

### Sample Input

```
7 2 1 4 5 1 3 3
4 1000 1000 1000 1000
0
```

### Sample Output

```
8
4000
```

### Hint

Huge input, scanf is recommended.

## 分析

题目大意：在一水平线上方有若干个矩形，求包含于这些矩形的并集内部的最大矩形的面积，矩形个数 $\leq 10^{5}$ 。

我们现在面临两个问题：

- 应从哪个位置开始选取所需的矩形并集？
- 当确定了开始位置时，应向左/右哪个方向延伸，延伸多少？

作为对问题的简化，我们先考虑如下情况：如果矩形高度从左到右单调递增，答案将是多少？

![](http://www.bofc.tech/image/2018-9-4-01.png)

很显然，答案将是以下四种情形之一：

![](http://www.bofc.tech/image/2018-9-4-02.png)

那么，此时如果新增加一个矩形，它的高度比其之前的三个矩形都要低；此时，如果我们想要利用这个矩形以及之前的矩形一同选取一个并集，这个并集的高度一定不会高于新矩形的高度：也就是说，下图中打叉的部分已经对于后续计算没有用处了。那么，我们就可以将新选取的并集独立出来，代替之前用到的所有矩形，放入我们已有的矩形序列之内：此时，矩形序列又重新具有了高度单调性。

![](http://www.bofc.tech/image/2018-9-4-03.png)

因此，我们可以采用单调栈维护矩阵序列：我们存储序列中每一个矩形的高度和宽度，之后扫描所有矩形；每当读入一个新矩形时进行如下操作：

- 如果当前矩形的高度大于等于栈顶矩形，则直接将当前矩形压入栈顶，宽度为1。
- 如果当前矩形的高度小于栈顶矩形，则持续将栈顶矩形出栈，直至当前矩形高度大于等于栈顶矩形为止。同时，在这一过程中，累积记录所有出栈矩形的宽度；当出栈完毕后，再将以累积值为宽度、当前矩形高度为高的新矩形压入栈顶。

在扫描结束后，为了防止栈中仍有矩形未被弹出，我们可以增加一个高度为0的矩形 `h[n + 1]` ，以此简化计算。

注意：此题最终答案会爆int。

### 代码

```
#include <iostream>
#include <cstdio>
#include <cstring>
#include <algorithm>
using namespace std;

typedef long long ll;

const int MAXN = 1e5 + 10;
int h[MAXN];
int s[MAXN], w[MAXN], top;

void push(int hei, int wid);
void pop(int* hei, int* wid);
bool isEmpty();
int main() {
    ios::sync_with_stdio(false);
    cin.tie(0);

    int n = 0;

    while(cin >> n && n) {
        for(int i = 1; i <= n; i++)
            cin >> h[i];
        h[n + 1] = 0;

        top = 0;
        memset(s, 0, sizeof(s));
        memset(w, 0, sizeof(w));

        ll ans = 0;
        for(int i = 1; i <= n + 1; i++) {
            if(h[i] >= s[top]) s[++top] = h[i], w[top] = 1;
            else {
                int outWidth = 0;

                while(h[i] < s[top]) {
                    outWidth += w[top];
                    ans = max(ans, (long long)s[top--] * outWidth);
                }

                s[++top] = h[i], w[top] = outWidth + 1;
            }
        }

        cout << ans << endl;
    }

    return 0;
}

inline void push(int hei, int wid) {
    s[++top] = hei;
    w[top] = wid;
}

inline void pop(int* hei, int* wid) {
    *hei = s[top];
    *wid = w[top--];
}

inline bool isEmpty() {
    if(top == 0) return true;
    else return false;
}
```
