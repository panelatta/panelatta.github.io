---
categories:
- Programming Contest
- Leetcode
- Data Structure
date: '2020-11-29T22:22:11+08:00'
tags:
- Leetcode
- Hard
- 逆序对
- 归并排序
- 树状数组
title: '[Leetcode 493]翻转对（逆序对，归并排序/树状数组）'
toc: true
---

一道逆序对的变体题目，稍作改变即可解决。

<!--more-->

## 题面

给定一个数组 `nums` ，如果 `i < j` 且 `nums[i] > 2*nums[j]` 我们就将 `(i, j)` 称作一个重要翻转对。

你需要返回给定数组中的重要翻转对的数量。

示例 1:

> 输入: [1,3,2,3,1]
> 输出: 2

示例 2:

> 输入: [2,4,3,5,1]
> 输出: 3

注意:

- 给定数组的长度不会超过50000。
- 输入数组中的所有数字都在32位整数的表示范围内。

## 题解

### 归并排序

#### 讲解

在归并排序的过程中利用两个数组均为有序的特性，用两个指针分别指向 ${\rm mid}$ 和 ${\rm r}$ 处并不断向左移动，过程中即可统计翻转对。

#### 代码

```cpp
class Solution {

#define COUT(x) #x << "->" << (x) << "   " 

public:
    int cnt;

    int reversePairs(vector<int>& nums) {
        int n = nums.size();
        if(!n) return 0;

        vector<int> helper(n);
        cnt = 0;

        mergeSort(nums, helper, 0, n - 1);
        return cnt;
    }
    void mergeSort(vector<int> &a, vector<int> &b, int l, int r) {
        if(l == r) return;

        int mid = (l + r) / 2;
        mergeSort(a, b, l, mid);
        mergeSort(a, b, mid + 1, r);

        for(int i = mid, j = r; i >= l && j >= mid + 1; i--) {
            bool flag = false;

            while(j >= mid + 1) {
                if((long long)a[i] > 2LL * a[j]) {
                    flag = true;
                    break;
                }
                j--;
            }

            if(flag) {
                cnt += (j - mid);
            }
        }

        int i = l, j = mid + 1;
        for(int k = l; k <= r; k++) {
            if(j > r || i <= mid && a[i] <= a[j]) {
                b[k] = a[i++];
            } else {
                b[k] = a[j++];
            }
        }

        for(int k = l; k <= r; k++)
            a[k] = b[k];
    }
};

```

### 树状数组★

#### 讲解

与通常的树状数组维护逆序对不同，这里需要维护的是 ${\rm nums}[i]$ 与 $2\cdot{\rm nums}[j]$ 的关系，因此需要做如下变动：

记 $n={\rm nums.size()}$，先将 ${ \{ {\rm nums}[i],\,2\cdot{\rm nums}[i]\;\;|\;\;0 \leq i < n \} }$ 离散化，记为 $m$；之后以 $[1..2n]$ 初始化树状数组；

此时，对每个 $j\;(0 \leq j < n)$，我们试图统计 ${\rm nums}[j]$ 左侧大于 $2 \cdot {\rm nums}[j]$ 的数目。因此我们正向扫描 ${\rm nums}$，并在过程中对于每个 $j$：

- 计算 ${\rm ask}(2n) - {\rm ask}(m[2 \cdot {\rm nums}[j]])$，这是 ${\rm nums}[j]$ 之前**被扫描过的**，大于 $2 \cdot {\rm nums}[j]$ 的数目；
- ${\rm add}(m[{\rm nums}[j]], 1)$。

这样一边扫描一边更新，即可得出所有翻转对个数。

另外，由于离散化需要排序，树状数组做法的常数比归并排序大。

#### 代码

```cpp
class Solution {

#define COUT(x) #x << "->" << (x) << "   "

public:
    struct BinTree {
        vector<int> c;
        int n;

        BinTree(int _size): n(_size) {
            c.resize(_size + 1);
        }
        static constexpr int lowbit(int x) {
            return (x & (-x));
        }
        int ask(int x) {
            int ans = 0;
            for( ; x; x -= lowbit(x)) 
                ans += c[x];
            return ans;
        }
        void add(int x, int y) {
            for( ; x <= n; x += lowbit(x))
                c[x] += y;
        }
    };

    int reversePairs(vector<int>& nums) {
        int n = (int)nums.size();
        set<long long> s;
        for(int i = 0; i < n; i++) {
            s.insert(nums[i]);
            s.insert(2LL * nums[i]);
        }

        unordered_map<long long, int> m;
        int cnt = 0;
        for(auto &it : s) {
            m.insert(make_pair(it, ++cnt));
        }

        BinTree t(cnt);
        int ans = 0;
        for(int i = 0; i < n; i++) {
            int right = t.ask(cnt);
            int left = t.ask(m[2LL * nums[i]]);
            ans += right - left;
            t.add(m[nums[i]], 1);
        }
        return ans;
    }
};

```
