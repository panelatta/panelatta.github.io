---
author: Panelatta
categories:
- Algorithm
- Basic
- Bitwise operation
cid: 89
date: '2018-06-14T00:08:00+08:00'
layout: post
mathjax: true
status: publish
tags:
- ACM题解
thumb: null
thumbStyle: small
title: Vijos.1197 费解的开关
updated: 2019-08-16 16:00:11
viewsNum: 6157
---

<!--more-->

## 题目

### 描述

> 你玩过“拉灯”游戏吗？25盏灯排成一个5x5的方形。每一个灯都有一个开关，游戏者可以改变它的状态。每一步，游戏者可以改变某一个灯的状态。游戏者改变一个灯的状态会产生连锁反应：和这个灯上下左右相邻的灯也要相应地改变其状态。
>
> 我们用数字“1”表示一盏开着的灯，用数字“0”表示关着的灯。下面这种状态
>
> 10111  
> 01101  
> 10111  
> 10000  
> 11011  
>
> 在改变了最左上角的灯的状态后将变成：
>
> 01111  
> 11101  
> 10111  
> 10000  
> 11011  
>
> 再改变它正中间的灯后状态将变成：
>
> 01111  
> 11001  
> 11001  
> 10100  
> 11011  
>
> 给定一些游戏的初始状态，编写程序判断游戏者是否可能在6步以内使所有的灯都变亮。

### 格式

#### 输入格式

> 第一行有一个正整数n，代表数据中共有n个待解决的游戏初始状态。
>
> 以下若干行数据分为n组，每组数据有5行，每行5个字符。每组数据描述了一个游戏的初始状态。各组数据间用一个空行分隔。
>
> 对于30%的数据，n<=5；
>
> 对于100%的数据，n<=500。

#### 输出格式

> 输出数据一共有n行，每行有一个小于等于6的整数，它表示对于输入数据中对应的游戏状态最少需要几步才能使所有灯变亮。
>
> 对于某一个游戏初始状态，若6步以内无法使所有灯变亮，请输出“-1”。

### 样例1

#### 样例输入1

> 3
>
> 00111  
> 01011  
> 10001  
> 11010  
> 11100  
>
> 11101  
> 11101  
> 11110  
> 11111  
> 11111  
>
> 01111  
> 11111  
> 11111  
> 11111  
> 11111  

#### 样例输出1

> 3  
> 2  
> -1  

## 解法

### 详细思路

一开始面对此题我们可以很容易想到使用BFS或DFS来搜索从给定状态是否能够达到全亮的状态，但是对于多组数据的情况这种解法的时间复杂度会不太理想。

我们不妨换一种思考模式：既然我们可以从给定的状态正向搜索出全亮的状态，我们也就可以从全亮的状态反向搜索出给定的状态。因此我们可以采用这样的方式：在程序开始处进行一次初始化，从全亮的状态进行一次BFS，搜索出所有6步以内可以达到的状态并记录步数。之后每读入一个状态就可以立即给出这种状态所需的步数了。显然这个题使用位运算来记录状态会非常方便。

### 代码

```
#include <cstdio>
#include <cstring>
#include <queue>
#include <algorithm>

using namespace std;

int map[1 << 25];

void bfs();
int press(int status, int num);
int main() {
	memset(map, -1, sizeof(map));
	bfs();

	int n = 0;
	scanf("%d", &n);

	while(n--) {
		int light = 0;
		char line[10];

		for(int i = 0; i < 5; i++) {
			scanf("%s", line);

			for(int j = 0; j < 5; j++) {
				light <<= 1;
				light |= (line[j] - '0');
			}
		}

		printf("%d\n", map[light]);
	}

	return 0;
}

int press(int status, int num) {
	int pre = status;

	status ^= (1 << num);
	if(num % 5 != 0) status ^= (1 << (num - 1));
	if(num % 5 != 4) status ^= (1 << (num + 1));
	if(num / 5 != 0) status ^= (1 << (num - 5));
	if(num / 5 != 4) status ^= (1 << (num + 5));

	if(pre == status || map[status] != -1)
		return -1;
	else if(map[status] == -1) {
		map[status] = map[pre] + 1;
		return status;
	}
}

void bfs() {
	queue<int> q;
	
	int status = (1 << 25) - 1;
	map[status] = 0;

	q.push(status);

	while(!q.empty()) {
		status = q.front();
		q.pop();

		if(map[status] < 6) {
			for(int i = 0; i < 25; i++) {
				int now = press(status, i);

				if(now != -1) q.push(tmp);
			}
		}
	}
}
```

## 优化

### 详细思路

按照上面的做法我们需要处理的状态空间仍比较大，能不能尽量缩小？观察这个题我们可以发现两点性质：

1. 每个位置至多只会被点击一次
2. 如果固定了第一行的点击方案，则整个矩阵的点击方案也都会被确定

其中性质1显然成立。下证性质2：

> 我们将命题2改写为其等价命题：“如果固定了第1行的点击方案，则第$k $行$k \geq 1$的满足题意的点击方案也被确定”。
>
> 采用归纳法进行证明：
>
> 当$p = 1$时，命题显然成立。
>
> 假定当$p=1,2,\cdots,k(k \geq 1)$时，命题成立；
>
> 那么当$p = k + 1 $时，因为前$k $行的点击方案均被确定，此时欲改变第$k $行内关闭的灯之状态，则必须改变其下方第$k+1 $行内对应灯之状态；同时$k+1$行内其他灯均不可改变状态，因若如此，第$k$行内已打开的灯将被关闭，此时不符题意。因此：第$k+1$行的点击方案完全由第$k$行决定，是固定的。故此时命题成立。
>
> 由归纳假设，命题对一切正整数$p$均成立。证毕。

因此我们只需要枚举第1行的点击方案（共32种），而第2，3，4，5行的点击方案均可由第1行的点击方案地推得到，大大缩小了我们需要处理的状态空间。

### 代码

```
#include <cstdio>
#include <cstring>
#include <cmath>
#include <algorithm>
using namespace std;

const int INF = 0x3f3f3f3f;

int press(int status, int n);
int main() {
	int n = 0;
	scanf("%d", &n);

	while(n--) {
		int status = 0;

		char tmp[10];
		for(int i = 0; i < 5; i++) {
			scanf("%s", tmp);

			for(int j = 0; j < 5; j++) {
				status <<= 1;

				if(tmp[j] == '1') status |= 1;
			}
		}
		
		int mintime = INF;
		for(int i = 0; i < (1 << 5); i++) {
			int t = i, p = status, num = 0;

			for(int j = 0; j < 5; j++) {
				if(((t >> (4 - j)) & 1) == 1) {
					p = press(p, 24 - j);
					num++;
				}
			}

			for(int j = 1; j < 5; j++) {
				for(int k = 0; k < 5; k++) {
					if(((p >> (24 - 5 * j + 5 - k)) & 1) == 0) {
						p = press(p, 24 - 5 * j - k);
						num++;
					}
				}
			}
			
			bool flag = true;
			for(int j = 0; j < 5; j++) {
				if((p & 1) == 0) {
					flag = false;
					break;
				}

				p >>= 1;
			}

			if(flag) {
				mintime = min(mintime, num);
			}
		}

		printf("%d\n", mintime > 6 ? -1 : mintime);
	}

	return 0;
}

int press(int status, int n) {
	status ^= (1 << n);
	if(n / 5 != 4) status ^= (1 << (n + 5));
	if(n / 5 != 0) status ^= (1 << (n - 5));
	if(n % 5 != 4) status ^= (1 << (n + 1));
	if(n % 5 != 0) status ^= (1 << (n - 1));
	return status;
}
```
