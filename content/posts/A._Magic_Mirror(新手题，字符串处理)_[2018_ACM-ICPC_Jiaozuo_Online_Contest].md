---
author: Panelatta
categories:
- Programming Contest
- ACM
cid: 141
date: '2018-09-15T23:49:00+08:00'
layout: post
mathjax: true
status: publish
tags:
- ACM题解
thumb: null
thumbStyle: small
title: A. Magic Mirror(新手题，字符串处理) [2018 ACM-ICPC Jiaozuo Online Contest]
updated: 2019-08-16 15:50:05
viewsNum: 393
---

<!--more-->

## 题面

### Description

Jessie has a magic mirror.

Every morning she will ask the mirror: 'Mirror mirror tell me, who is the most beautiful girl in the world?' If the mirror says her name, she will praise the mirror: 'Good guy!', but if the mirror says the name of another person, she will assail the mirror: 'Dare you say that again?'

Today Jessie asks the mirror the same question above, and you are given a series of mirror's answers. For each answer, please output Jessie's response. You can assume that the uppercase or lowercase letters appearing anywhere in the name will have no influence on the answer. For example, 'Jessie' and 'jessie' represent the same person.

### Input

The first line contains an integer $T(1 \le T \le 100)$, which is the number of test cases.

Each test case contains one line with a single-word name, which contains only English letters. The length of each name is no more than $15$.

### Output

For each test case, output one line containing the answer.

### Sample Input

```
2
Jessie
Justin
```

### Sample Output

```
Good guy!
Dare you say that again?
```

## 题解

### 题目大意

给出 $T$个长度小于$15$ 的字符串，判断其是否与字符串`Jessie`相等（忽略大小写）。

### 分析

完全的新生级签到题，读入字符串后将每个字符都转为小写，之后判断是否与`jessie`相等即可。

## 代码

```
#include <iostream>
#include <cstdio>
#include <cstring>
#include <algorithm>
#include <cctype>
using namespace std;

const int MAXN = 20;
char name[MAXN];

int main() {
    int t = 0;
    scanf("%d", &t);

    while(t--) {
        scanf("%s", name);

        int len = (int)strlen(name);
        for(int i = 0; i < len; i++)
            name[i] = tolower(name[i]);
        
        if(!strcmp(name, "jessie")) printf("Good guy!\n");
        else printf("Dare you say that again?\n");
    }
    
    return 0;
}
```
