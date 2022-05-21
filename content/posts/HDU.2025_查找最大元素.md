---
author: Panelatta
categories:
- Programming Contest
- ACM
- HDU
cid: 28
date: '2017-12-19T22:34:00+08:00'
layout: post
mathjax: true
status: publish
tags:
- ACM题解
thumb: null
thumbStyle: small
title: HDU.2025 查找最大元素
updated: 2018-06-10 20:33:06
viewsNum: 233
---

# 题目

> Problem Description  
> 对于输入的每个字符串，查找其中的最大字母，在该字母后面插入字符串“(max)”。

> Input  
> 输入数据包括多个测试实例，每个实例由一行长度不超过100的字符串组成，字符串仅由大小写字母构成。

> Output  
> 对于每个测试实例输出一行字符串，输出的结果是插入字符串“(max)”后的结果，如果存在多个最大的字母，就在每一个最大字母后面都插入"(max)"。

> Sample Input  
>
	abcdefgfedcba
	xxxxx

> Sample Output  
>
	abcdefg(max)fedcba
	x(max)x(max)x(max)x(max)x(max)
	


<!--more-->


# 题解

```
#include <stdio.h>
#include <string.h>
#define FOR_TEST 0
#define STRING "(max)"
#define SIZE 110
char array[SIZE];
char FindMaxLetter(char* array);
void ArrayTrans(char* array, int startIndex, int length);
void StringInsert(char* array, int insertIndex, char* string);
int main(void){
    int i = 0;

    #if FOR_TEST
    sprintf(array, "%s", "Donald Trump you strange man");
    printf("%s\n", array);
    printf("%c\n", FindMaxLetter(array));
    for(i = 0; i < strlen(array); i++)
        if(array[i] == FindMaxLetter(array)){
            break;
        }
    ArrayTrans(array, i, strlen("SSY"));
    printf("%s\n", array);
    StringInsert(array, i, "SSY");
    printf("%s\n", array);
    #endif // FOR_TEST

    while(scanf("%s", array) != EOF){
        char maxLetter = FindMaxLetter(array);
        for(i = 0; i < strlen(array); i++){
            if(array[i] == maxLetter){
                ArrayTrans(array, i + 1, strlen(STRING));
                StringInsert(array, i + 1, STRING);
                i += strlen(STRING) - 1;
            }
        }
        printf("%s\n", array);
        memset(array, 0, sizeof array);
    }
    return 0;
}
char FindMaxLetter(char* array){
    int i = 0;
    char max = array[0];

    for(i = 0; array[i] != '\0'; i++)
        if(array[i] > max)
            max = array[i];
    return max;
}
void ArrayTrans(char* array, int startIndex, int length){
    int i = 0;

    for(i = strlen(array) + length; i >= startIndex; i--)
        array[i] = array[i - length];
}
void StringInsert(char* array, int insertIndex, char* string){
    int i = 0, j = 0;

    for(i = insertIndex, j = 0; i < insertIndex + strlen(string); i++, j++)
        array[i] = string[j];
}
```
