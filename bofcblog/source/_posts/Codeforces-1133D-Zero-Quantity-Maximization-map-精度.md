---
title: 'Codeforces 1133D. Zero Quantity Maximization (map, 精度)'
tags: []
date: 2019-03-10 14:41:00
---

<!--more-->

## 题面

### Description

You are given two arrays $a$ and $b$, each contains $n$ integers.

You want to create a new array $c$ as follows: choose some real (i.e. not necessarily integer) number $d$, and then for every $i \in [1, n]$ let $c_i := d \cdot a_i + b_i$.

Your goal is to maximize the number of zeroes in array $c$. What is the largest possible answer, if you choose $d$ optimally?

### Input

The first line contains one integer $n$ ($1 \le n \le 2 \cdot 10^5$) — the number of elements in both arrays.

The second line contains $n$ integers $a_1$, $a_2$, ..., $a_n$ ($-10^9 \le a_i \le 10^9$).

The third line contains $n$ integers $b_1$, $b_2$, ..., $b_n$ ($-10^9 \le b_i \le 10^9$).

### Output

Print one integer — the maximum number of zeroes in array $c$, if you choose $d$ optimally.

### Examples

#### Input

    5
    1 2 3 4 5
    2 4 7 11 3`</pre>

    #### Output
    <pre>`2`</pre>

    #### Input
    <pre>`3
    13 37 39
    1 2 3`</pre>

    #### Output
    <pre>`2`</pre>

    #### Input
    <pre>`4
    0 0 0 0
    1 2 3 4`</pre>

    #### Output
    <pre>`0`</pre>

    #### Input
    <pre>`3
    1 2 -1
    -6 -12 6`</pre>

    #### Output
    <pre>`3`</pre>

    ### Note

    In the first example, we may choose $d = -2$.

    In the second example, we may choose $d = -\dfrac{1}{13}$.

    In the third example, we cannot obtain any zero in array $c$, no matter which $d$ we choose.

    In the fourth example, we may choose $d = 6$.

    ## 题目大意

    给出两个长度为 $n$ $(1 \leq n \leq 2 \cdot 10^{5})$ 的数组 $a$ 和 $b$ ，求实数 $d$ 使得对所有 $i \in [1, n]$ 计算下式

    $$
    c[i] = d \cdot a[i] + b[i]
    $$

    数组 $c$ 中 $0$ 的数目尽可能多。

    ## 题解

    ### 分析

    令 $d \cdot a[i] + b[i] = 0$，则有 $d = -\dfrac{b[i]}{a[i]}$ 。但 $d$ 会爆 `double` 精度，此时用 `pair` 维护 `&lt;-b[i] / gcd, a[i] / gcd&gt;` 即可。但此时要注意处理 `b[i]` 与 `a[i]` 的正负号关系（e.g.  $\dfrac{1}{1} = \dfrac{-1}{-1}$ ，但在直接按此存储则会导致被认作为不同的值）。也可用 `long double` 维护 $d$ 。之后用 `map` 统计出现次数最多的 `d` 即可。

    注意特判 $a[i] = 0$ 的情况。此时有 $c[i] = b[i]$ ，若 $b[i] = 0$ ，则 $c[i]$ 必为 $0$。

    ### 代码

    #### `pair` 维护
    <pre>`#include &lt;bits/stdc++.h&gt;
    using namespace std;

    #define ABS(x) ((x) &gt; 0 ? (x) : -(x))

    const int MAXN = 2e5 + 10;

    int a[MAXN], b[MAXN];

    int main() {
        ios::sync_with_stdio(false);
        cin.tie(0);

        int n = 0;
        while (cin &gt;&gt; n) {
            for (int i = 1; i &lt;= n; i++)
                cin &gt;&gt; a[i];
            for (int i = 1; i &lt;= n; i++)
                cin &gt;&gt; b[i];

            int ans = 0, cnt0 = 0;

            map&lt;pair&lt;int, int&gt;, int&gt; m;
            for (int i = 1; i &lt;= n; i++) {
                if (a[i] == 0) {
                    if (b[i] == 0)
                        cnt0++;
                } else {
                    pair&lt;int, int&gt; p = make_pair(-b[i], a[i]);
                    if (p.first &lt; 0 || (p.first == 0 &amp;&amp; p.second &lt; 0)) {
                        p.first *= -1;
                        p.second *= -1;
                    }
                    int d = __gcd(ABS(p.first), ABS(p.second));
                    p.first /= d;
                    p.second /= d;

                    if (m.find(p) == m.end())
                        m.insert(make_pair(p, 1));
                    else
                        m[p]++;

                    ans = max(ans, m[p]);
                }
            }

            cout &lt;&lt; ans + cnt0 &lt;&lt; endl;
        }

        return 0;
    }`</pre>

    #### `long double`维护
    <pre>`#include &lt;bits/stdc++.h&gt;
    using namespace std;

    typedef long long          ll;
    typedef unsigned long long ull;
    typedef long double        ld;

    const int MAXN = 2e5 + 10;

    int a[MAXN], b[MAXN];

    int main() {
        ios::sync_with_stdio(false);
        cin.tie(0);

        int n = 0;
        while (cin &gt;&gt; n) {
            for (int i = 1; i &lt;= n; i++)
                cin &gt;&gt; a[i];
            for (int i = 1; i &lt;= n; i++)
                cin &gt;&gt; b[i];

            map&lt;ld, int&gt; m;
            int          ans = 0, cnt0 = 0;
            for (int i = 1; i &lt;= n; i++) {
                if (a[i] == 0) {
                    if (b[i] == 0)
                        cnt0++;
                } else {
                    ld d = -(ld)b[i] / a[i];

                    if (m.find(d) == m.end())
                        m.insert(make_pair(d, 1));
                    else
                        m[d]++;

                    ans = max(ans, m[d]);
                }
            }

            cout &lt;&lt; ans + cnt0 &lt;&lt; endl;
        }

        return 0;
    }