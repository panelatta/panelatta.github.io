---
author: Panelatta
categories:
- Programming Contest
- ACM
cid: 114
date: '2018-09-03T19:28:00+08:00'
layout: post
mathjax: true
status: publish
tags:
- ACM题解
- 数论
thumb: null
thumbStyle: small
title: A. An Olympian Math Problem (数论) [2018 ACM-ICPC Nanjing Online Contest]
updated: 2019-08-16 15:56:10
viewsNum: 195
---

<!--more-->

## Description

Alice, a student of grade $6$, is thinking about an Olympian Math problem, but she feels so despair that she cries. And her classmate, Bob, has no idea about the problem. Thus he wants you to help him. The problem is:

We denote $k!$:

$k! = 1 \times 2 \times \cdots \times (k - 1) \times k$

We denote $S$:

$S = 1 \times 1! + 2 \times 2! + \cdots +$
$(n - 1) \times (n-1)!$

Then $S$module$n$ is ____________

You are given an integer $n$.

You have to calculate $S$modulo$n$.

### Input

The first line contains an integer $T(T \le 1000)$, denoting the number of test cases.

For each test case, there is a line which has an integer $n$.

It is guaranteed that $2 \le n\le 10^{18}$.

### Output

For each test case, print an integer $S$modulo$n$.

### Hint

The first test is: $S = 1\times 1!= 1$, and $1$modulo $2$ is$1$.

The second test is: $S = 1\times 1!+2 \times 2!= 5$, and $5$modulo$3$ is$2$.

### Sample Input

```
2
2
3
```

### Sample Output

```
1
2
```

## 题解

首先，显然有 $S = \sum\limits_{k=1}^{n-1}k \cdot k! = \sum\limits_{k=1}^{n-1}((k+1)!-k!)=n!-1$.

故 $S \; \mathrm{mod} \; n$

$= (n! - 1) \; \mathrm{mod} \; n$

$ = (n! + n - 1) \; \mathrm{mod} \; n$

$ = n! \; \mathrm{mod} \; n + (n - 1) \; \mathrm{mod} \; n$

$ = n - 1$.

## 代码

```
#include <iostream>
#include <cstdio>
#include <cstring>
#include <algorithm>
using namespace std;

typedef long long ll;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(0);

    int t = 0;
    cin >> t;

    while(t--) {
        ll n = 0;
        cin >> n;
        cout << n - 1 << endl;
    }

    return 0;
}
```
