---
author: Panelatta
categories:
- Programming Contest
- ACM
cid: 61
date: '2018-03-24T19:15:00+08:00'
layout: post
mathjax: true
status: publish
tags:
- ACM题解
thumb: null
thumbStyle: small
title: AOJ.1301 差除
updated: 2018-06-10 20:30:05
viewsNum: 175
---

## 题目

> 题目描述
>
> 集合要满足互异性，即一个集合不能包含相同的元素。但是有的时候，我们需要集合中包含相同的元素，这种集合叫做多重集合（multiset）。  
> 现在有一个多重集合，其中有n个整数。现在需要你从其中选出k个整数，使得k个数中任意两个的差都可以被m整除。  
> 问题来了，能否从多重集合中找到k个数，若果可以的话，输出Yes，否则输出No。
>
> 


<!--more-->


>
> 程序输入说明
>
> 第一行，整数n,k,m，含义如题目所描述。  
> 第二行，n个整数。  
> 2<=k<=100000，1<=m<=100000  
>
> 程序输出说明
>
> 如果能找到，则输出Yes，否则输出No
>
> 程序输入样例
>
> 3 2 3  
> 1 8 4  
> 3 3 3  
> 1 8 4  
>
> 程序输出样例
>
> Yes  
> No
>
> 提示
>
> 对于第一组数据，可以找到两个数1、4，使得他们的差被3整除。输出Yes。  
> 对于第二组数据，找不到3个数，使得两两之间差被3整除，输出No。

## 分析

这个题不能直接上子集树（最后两组数据量比较大），必须对\\(O(N^{2})\\)算法进一步优化。

考虑k个数中任意两个的差都能被m整除这一点：这代表这两个数mod m的值相同（若\\(A\\equiv B(MOD \\: N)\\)，则\\(A-B\\equiv B-B(MOD \\: N)\\)）。因此，只需要记录每个数mod m的值，如果从0~m-1的范围内有某项的值超过了k，即可以认定存在k个数两两之差均可被m整除。

## 代码

```
#include <cstdio>
#include <cstring>
#include <algorithm>
using namespace std;
 
const int MAXM = 100010;
int ar[MAXM];
 
int main() {
    int n = 0, k = 0, m = 0;
 
    while(scanf("%d %d %d", &n, &k, &m) != EOF){
        memset(ar, 0, sizeof(ar));
         
        int tmp = 0;
        for(int i = 0; i < n; i++){
            scanf("%d", &tmp);
            ar[tmp % m]++;
        }
 
        bool flag = false;
        for(int i = 0; i < m; i++){
            if(ar[i] >= k){
                flag = true;
                break;
            }
        }
 
        printf(flag ? "Yes\n" : "No\n");
    }
 
    return 0;
}
```
