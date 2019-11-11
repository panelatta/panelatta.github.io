---
title: 'F. Sorting (排序，浮点数精度) [2017 CCPC China-Hunan Invitional]'
tags: []
date: 2018-09-07 22:10:00
---

<!--more-->

## Description

Bobo has $n$ tuples $(a_1, b_1, c_1), (a_2, b_2, c_2), \dots, (a_n, b_n, c_n)$ .
He would like to find the lexicographically smallest permutation $ p_1, p_2, \dots, p_n$ of $1, 2, \dots, n$ such that for $i \in \{2, 3, \dots, n\}$ it holds that

$$
\frac{a_{p_{i - 1}} + b_{p_{i - 1}}}{a_{p_{i - 1}} + b_{p_{i - 1}} + c_{p_{i - 1}}} \leq \frac{a_{p_i} + b_{p_i}}{a_{p_i} + b_{p_i} + c_{p_i}}
$$

### Input

The input consists of several test cases and is terminated by end-of-file.

The first line of each test case contains an integer $n$.

The $i$-th of the following $n$ lines contains $3$ integers $a_i$, $b_i$ and $c_i$.

### Output

For each test case, print $n$ integers $p_1, p_2, \dots, p_n$ seperated by spaces.
DO NOT print trailing spaces.

#### Constraint

*   $1 \leq n \leq 10^3$
*   $1 \leq a_i, b_i, c_i \leq 2 \times 10^9$
*   The sum of $n$ does not exceed $10^4$.

### Sample Input

    2
    1 1 1
    1 1 2
    2
    1 1 2
    1 1 1
    3
    1 3 1
    2 2 1
    3 1 1`</pre>

    ### Sample Output
    <pre>`2 1
    1 2
    1 2 3`</pre>

    ## 题解

    ### 题目大意

    给你 $n$ 个三元组，要求给出这 $n$ 个三元组的一个排列，使得对 $i \in \left \{ 2, 3, \cdots, n \right \} $ 都满足题给关系。

    ### 分析

    题给关系中的不等式只涉及 $p_{i - 1}$ 和 $p_{i}$ 两个元素，实际上相当于对三元组重载了小于号。因此，本题实际上是对读入的三元组序列进行排序。因此，我们用一个Node结构体存储三元组的三个变元和读入时在原序列中的位置即可。
    <pre>`struct Node {
        long long a, b, c;
        int id;
    }`</pre>

    同时，在比较三元组关系时，因为本题数据卡精度较严，因此不能用double，而应交叉相乘再比较，同时在这过程中约去一些相同的项（避免爆long long）。

    $$
    (a_{p_{i-1}}+b_{p_{i-1}})(a_{p_{i}}+b_{p_{i}}+c_{p_{i}}) \leq (a_{p_{i}} + b_{p_{i}})(a_{p_{i-1}}+b_{p_{i-1}}+c_{p_{i-1}}))
    $$

    $$
    (a_{p_{i-1}} + b_{p_{i-1}})c_{p_{i}} \leq (a_{p_{i}} + b_{p_{i}})c_{p_{i-1}}
    $$

    ## 代码
    <pre>`#include &lt;iostream&gt;
    #include &lt;cstdio&gt;
    #include &lt;cstring&gt;
    #include &lt;algorithm&gt;
    using namespace std;

    const int MAXN = 1010;
    typedef long long ll;

    struct Node {
        ll a, b, c;
        int id;

        bool operator &lt; (const Node&amp; x) const {
            ll q1 = c * (x.a + x.b);
            ll q2 = x.c * (a + b);

            if(q2 == q1) return id &lt; x.id;
            else return q2 &lt; q1;
        }
    } t[MAXN];

    int main() {
        ios::sync_with_stdio(false);
        cin.tie(0);

        int n = 0;
        while(cin &gt;&gt; n) {
            for(int i = 1; i &lt;= n; i++) {
                cin &gt;&gt; t[i].a &gt;&gt; t[i].b &gt;&gt; t[i].c;
                t[i].id = i;
            }

            sort(t + 1, t + n + 1);

            for(int i = 1; i &lt;= n; i++)
                if(i != n) cout &lt;&lt; t[i].id &lt;&lt; &quot; &quot;;
                else cout &lt;&lt; t[i].id &lt;&lt; endl;
        }

        return 0;
    }
    