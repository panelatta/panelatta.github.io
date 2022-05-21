---
author: Panelatta
categories:
- Programming Contest
- ACM
cid: 26
date: '2017-11-21T22:32:00+08:00'
layout: post
mathjax: true
status: publish
tags:
- ACM题解
thumb: null
thumbStyle: small
title: AOJ.645 约瑟夫环
updated: 2018-06-10 20:33:15
viewsNum: 189
---

> 约瑟夫环问题：设有编号为1，2，……，n的n(n>0)个人围成一个圈，从第1个人开始报数，报到m时停止报数，报m的人出圈，再从他的下一个人起重新报数，报到m时停止报数，报m的出圈，……，如此下去，直到所有人全部出圈为止。
>
> 程序输入说明：输入两个数 n和m，1<=n<=100,1<=m<=n
>
> 程序输出说明：每组输出一行，表示n个人出圈的顺序，相邻两个数字之间隔一个空格
>
> 程序输入样例：6 2
>
> 程序输出样例：2 4 6 3 1 5


<!--more-->


# 分析

因为题目中的n个成员构成一个环图，故声明一个Joseph数组，以数组下标序列作为成员序列，并将每个数组成员的值设为与其相连的下一个数组成员的下标（例：n == 3时，有Joseph[1] == 2, Joseph[2] == 3, Joseph[3] == 1)。从第一个数组成员开始计数，每当计数至m名成员时，即将第m名成员的前一名成员的指向设为第m名成员的指向（例：如果有Joseph[2] == 5, Joseph[5] == 7, 则将Joseph[2]设为7，使沿着环计数时不会再遍历至Joseph[5], 从而将Joseph[5]踢出环图）并输出第m名成员的下标。一直进行至存在Joseph[i] == i，此时环内还剩一名成员，遍历结束，输出这名成员的下标。

# 题解

```
#include <stdio.h>
#include <string.h>
#define SIZE 110
int Joseph[SIZE];
	// 递归地遍历环，判断是否要将第pepNum名成员踢出环
int kickOutOfRing(int lastPepNum, int pepNum, int m, int lifeNum);  

int main(void){
    int n = 0, m = 0;
    int i = 0;      
		
		// 初始化Joseph数组并将n名成员全部加入环
    memset(Joseph, 0, sizeof Joseph);
    scanf("%d %d", &n, &m);
    for(i = 1; i <= n - 1; i++){
        Joseph[i] = i + 1;
    }
    Joseph[n] = 1;

    printf("%d\n", kickOutOfRing(n, 1, m, 1));  // 开始遍历环，并输出最后一名成员的下标
    return 0;
}

int kickOutOfRing(int lastPepNum,  // 与第pepNum名成员相连的上一个成员之下标
                  int pepNum,      // 要判断是否踢出环的成员之下标
                  int m,           // 即输入的m
                  int lifeNum      // 计数在踢出的两名成员之间已经遇到几个成员
				 ){ 
    if(Joseph[pepNum] == pepNum)
        return pepNum;   		   // 如果只剩一名成员，直接返回其下标，结束递归
    else{
        if(lifeNum == m){          // 如果距上一次踢出某个成员起，已经遇到m名成员
            Joseph[lastPepNum] = Joseph[pepNum];  // 更改指向，踢出成员
            printf("%d ", pepNum);
            lifeNum = 1;           // 初始化计数器
            return kickOutOfRing(lastPepNum, Joseph[pepNum], m, lifeNum); 
        } else {
            lifeNum++;
            return kickOutOfRing(pepNum, Joseph[pepNum], m, lifeNum);
        }
    }
}
```
