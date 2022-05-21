---
author: Panelatta
categories:
- Algorithm
- Graph
- Shortest Path
cid: 16
date: '2018-06-06T17:54:00+08:00'
layout: post
mathjax: true
status: publish
tags:
- ACM题解
thumb: null
thumbStyle: small
title: PAT.1003 Emergency
updated: 2019-08-16 16:00:26
viewsNum: 244
---

<!--more-->

## 题目 ##

As an emergency rescue team leader of a city, you are given a special map of your country.  The map shows several scattered cities connected by some roads.  Amount of rescue teams in each city and the length of each road between any pair of cities are marked on the map.  When there is an emergency call to you from some other city, your job is to lead your men to the place as quickly as possible, and at the mean time, call up as many hands on the way as possible. 

> **输入描述**
>
> Each input file contains one test case. For each test case, the first line contains 4 positive integers: N (<= 500) - the number of cities (and the cities are numbered from 0 to N-1), M - the number of roads, C1 and C2 - the cities that you are currently in and that you must save, respectively.  The next line contains N integers, where the i-th integer is the number of rescue teams in the i-th city.  Then M lines follow, each describes a road with three integers c1, c2 and L, which are the pair of cities connected by a road and the length of that road, respectively.   It is guaranteed that there exists at least one path from C1 to C2. 
>
> **输出描述**
>
> For each test case, print in one line two numbers: the number of different shortest paths between C1 and C2, and the maximum amount of rescue teams you can possibly gather.  All the numbers in a line must be separated by exactly one space, and there is no extra space allowed at the end of a line.



> **Input**
>
> ```c++
> 5 6 0 2
> 1 2 1 5 3
> 0 1 1
> 0 2 2
> 0 3 1
> 1 2 1
> 2 4 1
> 3 4 1
> ```

> **Output**
>
> ```c++
> 2 4
> ```

### 题目翻译 ###

作为一个城市紧急援救队的指挥者，你得到了一个国家的特殊地图。地图上分散着几座城市，城市间用道路连接着。每个城市援救队的数量以及两座城市之间每条道路的长度已经在地图上标出。当某些城市发生了突发事件，需要你的帮助时，你的工作是带领你的队伍尽快的赶到事发现场，与此同时，召集尽可能多的在路上的队伍。

 

> 输入
>
> 每个输入文件包含一个测试实例。每个实例的第一行有四个正整数：N(<= 500)是城市的个数（城市的编号从0到N-1），M是道路的个数，C1和C2分别是你现在所在的城市以及你必须去救援的城市。下一行有N个整数，第i个整数是第i个城市中救援队的数量。然后下面有M行，每行表示一条道路。每一行有三个整数c1,c2和L，分别表示道路连接的两个城市以及道路的长度。保证C1到C2之间存在至少一条路径。

 

> 输出
>
> 对于每个测试实例，在一行中输出两个数字：C1和C2之间不同的最短路径的个数，你能聚集起来的最多的救援队数量。
>
> 一行中的所有数字必须被一个空格分隔开，在每行的结尾不允许出现空格。



## 代码 ##

```c++
#include <cstdio>
#include <cstring>
#include <queue>
#include <algorithm>
using namespace std;

#define MEM(x, v) memset((x), (v), sizeof((x)))
const int MAXN = 510;
const int INF = 0x3f3f3f3f;

class Node {
public:
	int l, v;
		
	Node() {}
	Node(int a, int b) {
		l = a; v = b;
	}
		
	bool operator < (const Node & p) const {
		return l > p.l;
	}
};
int vis[MAXN];
int minLen[MAXN];
int nvalue[MAXN];
int minRoad[MAXN];
int maxSave[MAXN];
int map[MAXN][MAXN];
int n, m, c1, c2;

void init();
void dijkstra(Node& start);
int main() {
	while(scanf("%d %d %d %d", &n, &m, &c1, &c2) != EOF) {
		init();
		
		for(int i = 0; i < n; i++)
			scanf("%d", &nvalue[i]);
		
		int tmp1 = 0, tmp2 = 0, tmpL = 0;
		for(int i = 0; i < m; i++) {
			scanf("%d %d %d", &tmp1, &tmp2, &tmpL);
			map[tmp1][tmp2] = map[tmp2][tmp1] = tmpL;
		}
		
		Node p = Node(0, c1);
		dijkstra(p);
		
		printf("%d %d\n", minRoad[c2], maxSave[c2]);
	}
	
	return 0;
}

inline void init() {
	MEM(vis, 0);
	MEM(minLen, INF);
	MEM(nvalue, 0);
	MEM(map, INF);
	MEM(minRoad, 0);
	MEM(maxSave, 0);
}

void dijkstra(Node& start) {
	priority_queue <Node> q;
	
	q.push(start);
	minRoad[c1] = 1;
	maxSave[c1] = nvalue[c1];
	
	Node now;
	while(!q.empty()) {
		now = q.top();
		q.pop();
		vis[now.v] = true;
		
		for(int i = 0; i < n; i++) {
			if(!vis[i] && map[now.v][i] != INF) {
				if(minLen[i] > now.l + map[now.v][i]) {
					minLen[i] = now.l + map[now.v][i];
					maxSave[i] = maxSave[now.v] + nvalue[i];
					minRoad[i] = minRoad[now.v];
				
					q.push(Node(minLen[i], i));
				} else if (minLen[i] == now.l + map[now.v][i]) {
					minRoad[i] += minRoad[now.v];
					maxSave[i] = max(maxSave[i], maxSave[now.v] + nvalue[i]);
				}
			}
			
		}
	}
}
```
