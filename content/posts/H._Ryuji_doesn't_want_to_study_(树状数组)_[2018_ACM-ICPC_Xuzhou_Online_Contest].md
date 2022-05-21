---
author: Panelatta
categories:
- Programming Contest
- ACM
cid: 137
date: '2018-09-09T21:10:00+08:00'
layout: post
mathjax: true
status: publish
tags: null
thumb: null
thumbSmall: null
thumbStyle: small
title: H. Ryuji doesn't want to study (树状数组) [2018 ACM-ICPC Xuzhou Online Contest]
updated: 2019-08-16 15:50:50
viewsNum: 243
---

<!--more-->

## 题面

### Description

Ryuji is not a good student, and he doesn't want to study. But there are n books he should learn, each book has its knowledge $a[i]$.

Unfortunately, the longer he learns, the fewer he gets.

That means, if he reads books from ll to rr, he will get $a[l] \times L + a[l+1] \times (L-1) + \cdots + a[r-1] \times 2 + a[r]$($L$is the length of [ $ l, r$ ] that equals to$r - l + 1$).

Now Ryuji has $q$ questions, you should answer him:

- If the question type is $1$, you should answer how much knowledge he will get after he reads books [ $l, r$ ].

- If the question type is $2$, Ryuji will change the $i$th book's knowledge to a new value.

### Input

First line contains two integers $n$and$q$ ($n, q \le 100000$).

The next line contains n integers represent $a[i]$ $(a[i]≤1e9)$ .

Then in next $q$line each line contains three integers $a, b, c$, if $a = 1$, it means question type is $1$, and $b, c$represents [ $l , r$]. if $a = 2$, it means question type is$2$ , and$b, c$ means Ryuji changes the$b$th book's knowledge to$c$ .

### Output

For each question, output one line with one integer represent the answer.

### Sample Output

```
5 3
1 2 3 4 5
1 1 3
2 5 0
1 4 5
```

### Sample Output

```
10
8
```

## 分析

注意到题中公式可进行如下变形：

$a[l] \times L + a[l+1] \times (L-1) + \cdots + a[r-1] \times 2 + a[r]$

- = $\sum\limits_{k=l}^{r}(r-l+1-(k-l)) \cdot a[k]$
- = $\sum\limits_{k=l}^{r}(r-k+1) \cdot a[k]$
- = $(r+1)\sum\limits_{k=l}^{r}a[k]-\sum\limits_{k=l}^{r}k \cdot a[k]$

又，题中所给两种操作分别为区间查询，单点修改；因此用树状数组直接维护 $a[k]$和$k \cdot a[k]$ 的值即可。

## 代码

```
#include <iostream>
#include <cstdio>
#include <cstring>
#include <algorithm>
using namespace std;

typedef long long ll;
#define LOWBIT(x) ((x) & -(x))

const int MAXN = 1e5 + 10;
ll a[MAXN];
ll c[MAXN], mc[MAXN];

ll ask(ll* ar, int x) {
    ll ans = 0;
    for( ; x; x -= LOWBIT(x)) ans += ar[x];
    return ans;
}

void add(ll* ar, int x, ll y, int n) {
    for( ; x <= n; x += LOWBIT(x)) ar[x] += y;
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(0);

    int n = 0, q = 0;
    while(cin >> n >> q) {
        for(int i = 1; i <= n; i++)
            cin >> a[i];

        for(int i = 1; i <= n; i++)
            add(c, i, a[i], n);
        for(int i = 1; i <= n; i++)
            add(mc, i, a[i] * (ll)i, n);

        for(int i = 1; i <= q; i++) {
            int p = 0, l = 0, r = 0;
            cin >> p >> l >> r;

            if(p == 1) {
                cout << (ll)(r + 1) * (ask(c, r) - ask(c, l - 1)) - (ask(mc, r) - ask(mc, l - 1)) << endl;
            }
            else if(p == 2) {
                ll l_c = ask(c, l) - ask(c, l - 1);
                ll l_mc = ask(mc, l) - ask(mc, l - 1);

                add(c, l, (ll)r - l_c, n);
                add(mc, l, (ll)r * (ll)l - l_mc, n);
            }
        }
    }

    return 0;
}

```
