---
author: Panelatta
categories:
- Programming Contest
- ACM
cid: 99
date: '2018-07-07T01:14:00+08:00'
layout: post
mathjax: true
status: publish
tags:
- ACM题解
thumb: null
thumbStyle: small
title: A.队列Q - WannyFly挑战赛19
updated: 2019-08-16 15:57:07
viewsNum: 152
---

<!--more-->

## [题目](https://www.nowcoder.com/acm/contest/131/A)

> 时间限制：C/C++ 1秒，其他语言2秒
> 空间限制：C/C++ 262144K，其他语言524288K
> 64bit IO Format: %lld

### 题目描述

> ZZT 创造了一个队列 Q。这个队列包含了 N 个元素，队列中的第 i 个元素用 Qi 表示。Q1 表示队头元素，QN 表示队尾元素。队列中的元素是 N 的一个全排列。 
> ZZT 需要在这个队列上执行 P 次操作，操作分两种：
> FIRST X: 将元素 X 移到队头。
> LAST X:  将元素 X 移到队尾。
> 在 P 次操作之后，ZZT 想知道队列中的元素的排列方式，由于他最近很忙，因此需要请你帮他解决这个问题。

### 输入描述:

```
第一行输入一个正整数 N，表示队列的大小。
第二行输入 N 个正整数，Q1, Q2, Q3, ... ..., QN，Qi 表示队列中的第 i 个元素。保证这 N 个数是 N 的一个全排列。
第三行输入一个正整数 P，表示接下来要进行的操作次数。

接下来 P 行，第 i 行输入一个字符串 Si 以及一个正整数 Xi，表示一次操作。
1 ≤ N ≤ 105.
1 ≤ Qi ≤ N.
1 ≤ P ≤  105.
Si  { “FIRST”, “LAST” }.
1 ≤ Xi ≤ 105.
```

### 输出描述:

```
输出 N 个正整数，表示 P 次操作之后的队列。
```

### 示例1

#### 输入

```
4
4 2 1 3
3
FIRST 4
LAST 2
LAST 1
```

#### 输出

```
4 3 2 1
```

## 题解

这个题的数据量比较大，用类似插入排序的方法只能过65%的数据，但因为题目给出的数据是n的全排列，因此队列中不会有重复的数据，所以可以另开一个数组维护队列中每个元素的位置，之后要用到某个元素的位置时根据值反查位置。

同时因为移动位置操作开销较大，可开一个较大的数组（大概5e5），并从数组的中部开始存入队列的数据，并维护一个start和end指针来指示数组第一个元素的前一个位置和数组最末元素的后一个位置，每当出现元素移动位置事件时，修改start和end指针的位置，并采用懒惰删除的策略标记数组中原有位置，最后遍历整个队列数组打印队列。时间复杂度O(n+q)。

## 代码

```
#include <cstdio>
#include <cstring>
#include <cmath>
#include <algorithm>
using namespace std;

#define FIRST "FIRST"
#define LAST "LAST"

const int MAXN = 1e5;
int q[MAXN * 5];
int h[MAXN + 100];

int main(){
	int n = 0;
	
	while(scanf("%d", &n) != EOF) {
		int start = 2e5 - 1; 
		int end = start + n + 1;

		for(int i = 1; i <= n; i++) {
			scanf("%d", &q[i + start]);
			h[q[i + start]] = i + start;
		}

		int p =0;
		scanf("%d", &p);

		char tmp[10]; int x  =0;
		for(int i = 0; i < p; i++) {
			scanf("%s %d", tmp, &x);

			if(strcmp(FIRST, tmp) == 0) {
				q[start] = q[h[x]];
				q[h[x]] = -1;
				h[x] = start;
				start--;
			} else if(strcmp(LAST, tmp) == 0) {
				q[end] = q[h[x]];
				q[h[x]] = -1.;
				h[x] = end;
				end++;
			}
		}

		int ok = 0;
		for(int p = start + 1; p != end; p++) {
			if(q[p] != -1) {
				ok ? putchar(' ') : 1;

				printf("%d", q[p]);

				!ok ? ok = 1 : 1;
			} 
		}
		putchar('\n');
	}

	return 0;
}
```
