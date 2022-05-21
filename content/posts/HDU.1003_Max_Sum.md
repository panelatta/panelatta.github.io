---
author: Panelatta
categories:
- Programming Contest
- ACM
- HDU
cid: 38
date: '2018-02-09T22:59:00+08:00'
layout: post
mathjax: true
status: publish
tags:
- ACM题解
thumb: null
thumbStyle: small
title: HDU.1003 Max Sum
updated: 2018-06-10 20:32:32
viewsNum: 188
---

# 题目

> **Problem Description**
>
> Given a sequence a[1],a[2],a[3]......a[n], your job is to calculate the max sum of a sub-sequence. For example, given (6,-1,5,4,-7), the max sum in this sequence is 6 + (-1) + 5 + 4 = 14.


<!--more-->


> **Input**
>
> The first line of the input contains an integer T(1<=T<=20) which means the number of test cases. Then T lines follow, each line starts with a number N(1<=N<=100000), then N integers followed(all the integers are between -1000 and 1000).

> **Output**
>
> For each test case, you should output two lines. The first line is "Case #:", # means the number of the test case. The second line contains three integers, the Max Sum in the sequence, the start position of the sub-sequence, the end position of the sub-sequence. If there are more than one result, output the first one. Output a blank line between two cases.

> **Sample Input**
>
> 2  
> 5 6 -1 5 4 -7  
> 7 0 6 -1 1 -6 7 -5  

> **Sample Output**
>
> Case 1:  
> 14 1 4  
> 
> Case 2:  
> 7 1 6  

题目大意即是：给定一个序列\\(a\_{1},a\_{2},a\_{3},\\cdots,a\_{n}\\)，对\\(i,j\\in [1,\\cdots,n]\\)，求\\(\\sum\_{k = i}^{j} a\_{k}\\)的最大值，并给出\\(i\\)和\\(j\\)的值。

# 题解

通过对本题逐渐深入的分析，下面我们将给出三个时间复杂度逐渐降低的算法。

## 朴素算法：时间复杂度O(N ^ 3)

我们先忽略时间复杂度的要求而只考虑算法的正确性。由题意，我们所求的对象是题中给出序列的某个连续子序列，也即我们只需要枚举序列元素的下标i和j，求出\\(a\_{i}\\)到\\(a\_{j}\\)间所有元素的和，再同当前最大值进行比较即可得出正确答案。

```
#include <stdio.h>
#define LEN 100010
#define MAXNUM 1001

int array[LEN];

int main(void){
    int T = 0;
    scanf("%d", &T);

    for(int kase = 1; kase <= T; kase++){
        int n = 0;
        scanf("%d", &n);

        for(int i = 0; i < n; i++)
            scanf("%d", &array[i]);

        int maxSum = -MAXNUM, start = 0, end = 0;
        for(int i = 0; i < n; i++)
            for(int j = i; j < n; j++){
                int thisSum = 0;

                for(int k = i; k <= j; k++)
                    thisSum += array[k];
                
                if(thisSum > maxSum){
                    maxSum = thisSum;
                    start = i; end = j;
                }
            }
        
        printf("Case %d:\n", kase);
	printf("%d %d %d\n", maxSum, start + 1, end + 1);
        printf(kase == T ? "" : "\n");
    }

    return 0;
}
```

## 进阶算法：时间复杂度O(N ^ 2)

上一个算法的时间复杂度为O(N ^ 3)，虽然算法是正确的，但显然还需要进一步优化才能够提交。我们先从最清晰的方向入手：减少嵌套for循环的数目。

经过稍加思索就可以发现第一个算法的主要缺点：累加子序列和的过程与枚举\\(i\\)和\\(j\\)的过程是分离的，用了一个单独的for循环来进行处理。这个问题可以被很轻易地解决：学习选择排序的思路，在枚举\\(j\\)的过程中一同累加子序列和并进行判断。

```
#include <stdio.h>
#define LEN 100010
#define MAXNUM 1001

int array[LEN];

int main(void){
    int T = 0;
    scanf("%d", &T);

    for(int kase = 1; kase <= T; kase++){
        int n = 0;
        scanf("%d", &n);

        for(int i = 0; i < n; i++)
            scanf("%d", &array[i]);
        
        int maxSum = -MAXNUM, start = 0, end = 0;
        for(int i = 0; i < n; i++){
            int thisSum = 0;
            
            for(int j = i; j < n; j++){
                thisSum += array[j];

                if(thisSum > maxSum){
                    maxSum = thisSum;
                    start = i; end = j;
                }
            }
        }

        printf("Case %d:\n", kase);
        printf("%d %d %d\n", maxSum, start + 1, end + 1);
        printf(kase == T ? "" : "\n");
    }

    return 0;
}
```

## 最终算法：时间复杂度O(N)

还能不能再进一步优化？我们仍然从减少嵌套for循环的数目入手。我们想将核心循环部分减少至只需要一个for循环。这就要求我们不能再接着采用枚举i和j的思路，而是需要随着数据的读入实时判断。

我们来考察一个特殊的序列：3, 5, 6, -5, -1, -5, -4, 2, 5, 6。这个序列有10个元素。我们来模拟逐个读入该序列中元素并实时判断的过程：

读入第1个元素：3。此时maxSum = thisSum = 3, start = end = 1。  
读入第2个元素：5。此时maxSum = thisSum = 8, start = 1, end = 2。  
读入第3个元素：6。此时maxSum = thisSum = 14, start = 1, end = 3。  

这一阶段maxSum和thisSum一直是同步增长的。

读入第4个元素：-5。此时maxSum = 14, thisSum = 9，start = 1, end = 3。

此时，thisSum已经小于maxSum, 但是我们还不能认为我们所寻找的最大连续子序列就在此处结束：下一个元素可能是6，这样又会使thisSum > maxSum而更新最大连续子序列的范围。我们继续模拟过程：

读入第5个元素：-1。此时maxSum = 14, thisSum = 8, start = 1, end = 3。  
读入第6个元素：-5。此时maxSum = 14, thisSum = 3, start = 1, end = 3。  
读入第7个元素：-4。此时maxSum = 14, thisSum = -1, start = 1, end = 3。

此时thisSum < 0。第一个连续子序列的查找过程停止了。也就是说，现在我们已经能够确定：现阶段找到的最大连续子序列是第1~3个元素，和为14。继续读入接下来的元素将开始第二个连续子序列的查找。

为什么第一个连续子序列的查找在thisSum < 0时停止? 容易知道，thisSum现在是前7个元素构成的连续子序列的和，我们记为S1。我们又把后3个元素构成的连续子序列的和记作S2。因为S1 < 0，这就将导致S1 + S2 < S2。也就是说，此时S2一定比加上了前7个元素的序列全体元素之和要大，所以第8个元素之后的查找也就与前7个元素构成的连续子序列无关了。

这一现象阐述了下述的重要事实：**最大连续子序列不可能以一个和为负数的连续子序列作为前缀。**

我们继续模拟过程：

读入第8个元素：2. 此时maxSum = 14, thisSum = 2, start = 8, end = 8.  
读入第9个元素：5. 此时maxSum = 14, thisSum = 7, start = 8, end = 9.  
读入第10个元素：6. 此时maxSum = 14, thisSum = 13, start = 8, end = 10.  

数据读入到此结束。因为thisSum < maxSum，所以该序列中的最大连续子序列是第1~3个元素，和为14。

根据以上过程，我们可以写出最终优化后的算法：

```
#include <stdio.h>
#define MAXNUM -1001
int main(void){
    int T = 0;
    scanf("%d", &T);

    for(int kase = 1; kase <= T; kase++){
        int n = 0;
        scanf("%d", &n);

        int thisSum = 0, maxSum = MAXNUM;
        int start = 1, end = 1, startPosition = 1;

        for(int i = 1; i <= n; i++){
            int num = 0;
            scanf("%d", &num);

            thisSum += num;
            if(thisSum > maxSum){
                maxSum = thisSum;
                start = startPosition;
                end = i;
            }
            if(thisSum < 0){
                thisSum = 0; // 重置thisSum以开始下一个连续子序列的查找
                startPosition = i + 1; // 存储下一个连续子序列的开始位置
            }
        }

        printf("Case %d:\n", kase);
        printf("%d %d %d\n", maxSum, start, end);
        printf(kase == T ? "" : "\n");
    }

    return 0;
}
```
这个算法中有两点值得注意的地方：

!> MAXNUM的值很重要。只有大于MAXNUM的值会在判断过程中参与判断。因为maxSum在算法运行过程中只会更大而不会更小，从而若序列中有小于MAXNUM的元素，则该元素根本无法进入判断流程。当MAXNUM的值被设为0时问题会尤为显著：一切负数元素都会被忽略，则若序列如同-1, -2, -3, -4, -3, -5一般全由负数元素构成，则算法最后会给出最大子序列和为0。

x> startPosition变量的作用。为什么不能这样改写程序：  
```
if(thisSum > maxSum){
    maxSum = thisSum;
     end = i;
}
if(thisSum < 0){
    thisSum = 0;
    start = i + 1;
}
```

> 我们仍以之前举例使用的序列作为例子：3, 5, 6, -5, -1, -5, -4, 2, 5, 6。当算法运行到第7个元素时，thisSum < 0成立，从而start被修改为8。但是因为第8~10个元素并没有成为更大的连续子序列，因此end的值仍是3，这样造成算法的输出中start > end。关键在于start不应该随着算法运行到一个新序列的开始而立即改变值，而是应当在确定找到了新的最大连续子序列后再改变值。
