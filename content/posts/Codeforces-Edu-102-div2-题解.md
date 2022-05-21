---
categories:
- Programming Contest
- Codeforces
- Div. 2
date: '2021-01-15T17:11:47+08:00'
tags:
- Codeforces
- Div. 2
- 题解
title: 'Codeforces Edu. Round #102 (Div. 2) [Personal Summary]'
toc: true
---

这场前 4 题难度不高，后 3 题抽时间看一下。

## My Status

|  A   |  B   |  C   |  D   |  E   |  F   |  G   |
| :--: | :--: | :--: | :--: | :--: | :--: | :--: |
|  O   |  O   |  O   |  O   |  Ø   |  Ø   |  Ø   |

<!--more-->

## A. [Replacing Elements](https://codeforces.com/contest/1473/problem/A)

### Description ###

> Time Limit: 2 seconds
> Memory Limit: 256 megabytes

You have an array $a_1, a_2, \dots, a_n$. All $a_i$ are positive integers.

In one step you can choose three distinct indices $i$, $j$, and $k$ ($i \neq j$; $i \neq k$; $j \neq k$) and assign the sum of $a_j$ and $a_k$ to $a_i$, i. e. make $a_i = a_j + a_k$.

Can you make all $a_i$ lower or equal to $d$ using the operation above any number of times (possibly, zero)?

#### Input ####

The first line contains a single integer $t$ ($1 \le t \le 2000$) — the number of test cases.

The first line of each test case contains two integers $n$ and $d$ ($3 \le n \le 100$; $1 \le d \le 100$) — the number of elements in the array $a$ and the value $d$.

The second line contains $n$ integers $a_1, a_2, \dots, a_n$ ($1 \le a_i \le 100$) — the array $a$.

#### Output ####

For each test case, print $\texttt{YES}$, if it's possible to make all elements $a_i$ less or equal than $d$ using the operation above. Otherwise, print $\texttt{NO}$.

You may print each letter in any case (for example, $\texttt{YES}$, $\texttt{Yes}$, $\texttt{yes}$, $\texttt{yEs}$ will all be recognized as positive answer).

#### Example ####

##### Input #####

```
3
5 3
2 3 2 5 4
3 4
2 4 4
5 4
2 1 5 3 6
```

##### Output #####

```
NO
YES
YES
```

#### Note ####

In the first test case, we can prove that we can't make all $a_i \le 3$.

In the second test case, all $a_i$ are already less or equal than $d = 4$.

In the third test case, we can, for example, choose $i = 5$, $j = 1$, $k = 2$ and make $a_5 = a_1 + a_2 = 2 + 1 = 3$. Array $a$ will become $[2, 1, 5, 3, 3]$.

After that we can make $a_3 = a_5 + a_2 = 3 + 1 = 4$. Array will become $[2, 1, 4, 3, 3]$ and all elements are less or equal than $d = 4$.

### Solution

先检查是否有所有 $a_i \leq d$ 成立。

若不成立，则将 $a$ 按升序排序，检查是否有 $a_1 + a_2 \leq d$。若成立，则可用 $a_1 + a_2$ 替换每个大于 $d$ 的值，存在可行方案；否则不存在可行方案。

### Code

```c++
/*************************************************************/
#if __cplusplus < 201103L
    // For jury which unsupports C++11
 
#include <cstdio>
#include <cstring>
#include <cmath>
#include <cassert>
#include <iostream>
#include <algorithm>
#include <set>
#include <map>
#include <vector>
#include <string>
#include <queue>
using namespace std;
 
#define ffor(_var, _begin, _end, ...) \
    for(__typeof__(_end) _var = _begin; _var < _end; __VA_ARGS__)
#define rfor(_var, _rbegin, _rend, ...) \
    for(__typeof__(_rbegin) _var = _rbegin; _var > _rend; __VA_ARGS__)
#define cfor(_var, _cbegin, _cend, ...) \
    for(__typeof__(_cend) _var = _cbegin; _var != _cend; __VA_ARGS__)
 
#else
 
#include <bits/stdc++.h>
using namespace std;
 
#define ffor(_var, _begin, _end, ...) \
    for(decay<decltype(_end)>::type _var = _begin; _var < _end; __VA_ARGS__)
#define rfor(_var, _rbegin, _rend, ...) \
    for(decay<decltype(_rbegin)>::type _var = _rbegin; _var > _rend; __VA_ARGS__)
 
#endif
 
typedef long long ll;
typedef long double ld;
#define ABS(x) ((x) > 0 ? (x) : -(x))

const int INF = 0x3f3f3f3f;
 
// #define __DEBUG__
 
#ifdef __DEBUG__
#if defined _WIN32
#define _WINDEBUG
#include <windows.h>
inline std::ostream& __YELLOW__(std::ostream &s) {
    HANDLE hStdout = GetStdHandle(STD_OUTPUT_HANDLE); 
    SetConsoleTextAttribute(hStdout, 
         FOREGROUND_GREEN|FOREGROUND_RED|FOREGROUND_INTENSITY);
    return s;
}
inline std::ostream& __WHITE__(std::ostream &s) {
    HANDLE hStdout = GetStdHandle(STD_OUTPUT_HANDLE); 
    SetConsoleTextAttribute(hStdout, 
       FOREGROUND_RED|FOREGROUND_GREEN|FOREGROUND_BLUE);
    return s;
}
inline std::ostream& __RED__(std::ostream &s)
{
    HANDLE hStdout = GetStdHandle(STD_OUTPUT_HANDLE); 
    SetConsoleTextAttribute(hStdout, 
                FOREGROUND_RED|FOREGROUND_INTENSITY);
    return s;
}
#elif defined __linux__
#define _LINUXDEBUG
#define __YELLOW__ "\033[33;1m"
#define __WHITE__ "\033[0m"
#endif
#endif
 
#if defined _WINDEBUG || defined _LINUXDEBUG
#define ar2vec(_begin, _end) \
    vector<decay<iterator_traits<decltype(_begin)>::value_type>::type>(_begin, _end)
#define debug(x...) \
    do { cout << __YELLOW__ << #x << " -> "; err(x); } while(0)
void err() { cout << __WHITE__ << endl; }
template<typename T, typename... A>
void err(T a, A... x) { cout << __RED__ << a << __YELLOW__ << ' '; err(x...); }
template<template<typename...> class T, typename t, typename... A>
void err(T<t> a, A... x) { for(auto& v : a) cout << __RED__ << v << __YELLOW__ << ' '; err(x...); }
#else
#define ar2vec(...)
#define debug(...)
#endif
/*************************************************************/

const int MAXN = 100;
int a[MAXN + 10];

int main() {
    ios::sync_with_stdio(false);
    cin.tie(0);
    // freopen("test.in", "r", stdin);
    // freopen("test.out", "w", stdout);

    int t = 0;
    cin >> t;
    while(t--) {
        int n = 0, d = 0;
        cin >> n >> d;
        
        for(int i = 1; i <= n; i++)
            cin >> a[i];

        bool flag = true;
        for(int i = 1; i <= n; i++)
            if(a[i] > d) {
                flag = false;
                break;
            }

        if(flag) {
            cout << "YES" << endl;
            continue;
        }
        
        sort(a + 1, a + n + 1);
        if(a[1] + a[2] > d) cout << "NO" << endl;
        else cout << "YES" << endl;
    }

    return 0;
}
```

## B. [String LCM](https://codeforces.com/contest/1473/problem/B)

### Description ###

> Time Limit: 2 seconds
> Memory Limit: 256 megabytes

Let's define a multiplication operation between a string $a$ and a positive integer $x$: $a \cdot x$ is the string that is a result of writing $x$ copies of $a$ one after another. For example, "$\texttt{abc}$" $\cdot~2~=$ "$\texttt{abcabc}$", "$\texttt{a}$" $\cdot~5~=$ "$\texttt{aaaaa}$".

A string $a$ is divisible by another string $b$ if there exists an integer $x$ such that $b \cdot x = a$. For example, "$\texttt{abababab}$" is divisible by "$\texttt{ab}$", but is not divisible by "$\texttt{ababab}$" or "$\texttt{aa}$".

LCM of two strings $s$ and $t$ (defined as $LCM(s, t)$) is the shortest non-empty string that is divisible by both $s$ and $t$.

You are given two strings $s$ and $t$. Find $LCM(s, t)$ or report that it does not exist. It can be shown that if $LCM(s, t)$ exists, it is unique.

#### Input ####

The first line contains one integer $q$ ($1 \le q \le 2000$) — the number of test cases.

Each test case consists of two lines, containing strings $s$ and $t$ ($1 \le |s|, |t| \le 20$). Each character in each of these strings is either '$\texttt{a}$' or '$\texttt{b}$'.

#### Output ####

For each test case, print $LCM(s, t)$ if it exists; otherwise, print $\texttt{-1}$ . It can be shown that if $LCM(s, t)$ exists, it is unique.

#### Example ####

##### Input #####

```
3
baba
ba
aa
aaa
aba
ab
```

##### Output #####

```
baba
aaaaaa
-1
```

#### Note ####

In the first test case, "$\texttt{baba}$" = "$\texttt{baba}$" $\cdot~1~=$ "$\texttt{ba}$" $\cdot~2$.

In the second test case, "$\texttt{aaaaaa}$" = "$\texttt{aa}$" $\cdot~3~=$ "$\texttt{aaa}$" $\cdot~2$.

### Solution

注意到 $s$ 和 $t$ 的长度均不超过 $20$，因此直接模拟即可。

### Code

```c++
/*************************************************************/
#if __cplusplus < 201103L
    // For jury which unsupports C++11
 
#include <cstdio>
#include <cstring>
#include <cmath>
#include <cassert>
#include <iostream>
#include <algorithm>
#include <set>
#include <map>
#include <vector>
#include <string>
#include <queue>
using namespace std;
 
#define ffor(_var, _begin, _end, ...) \
    for(__typeof__(_end) _var = _begin; _var < _end; __VA_ARGS__)
#define rfor(_var, _rbegin, _rend, ...) \
    for(__typeof__(_rbegin) _var = _rbegin; _var > _rend; __VA_ARGS__)
#define cfor(_var, _cbegin, _cend, ...) \
    for(__typeof__(_cend) _var = _cbegin; _var != _cend; __VA_ARGS__)
 
#else
 
#include <bits/stdc++.h>
using namespace std;
 
#define ffor(_var, _begin, _end, ...) \
    for(decay<decltype(_end)>::type _var = _begin; _var < _end; __VA_ARGS__)
#define rfor(_var, _rbegin, _rend, ...) \
    for(decay<decltype(_rbegin)>::type _var = _rbegin; _var > _rend; __VA_ARGS__)
 
#endif
 
typedef long long ll;
typedef long double ld;
#define ABS(x) ((x) > 0 ? (x) : -(x))

const int INF = 0x3f3f3f3f;
 
// #define __DEBUG__
 
#ifdef __DEBUG__
#if defined _WIN32
#define _WINDEBUG
#include <windows.h>
inline std::ostream& __YELLOW__(std::ostream &s) {
    HANDLE hStdout = GetStdHandle(STD_OUTPUT_HANDLE); 
    SetConsoleTextAttribute(hStdout, 
         FOREGROUND_GREEN|FOREGROUND_RED|FOREGROUND_INTENSITY);
    return s;
}
inline std::ostream& __WHITE__(std::ostream &s) {
    HANDLE hStdout = GetStdHandle(STD_OUTPUT_HANDLE); 
    SetConsoleTextAttribute(hStdout, 
       FOREGROUND_RED|FOREGROUND_GREEN|FOREGROUND_BLUE);
    return s;
}
inline std::ostream& __RED__(std::ostream &s)
{
    HANDLE hStdout = GetStdHandle(STD_OUTPUT_HANDLE); 
    SetConsoleTextAttribute(hStdout, 
                FOREGROUND_RED|FOREGROUND_INTENSITY);
    return s;
}
#elif defined __linux__
#define _LINUXDEBUG
#define __YELLOW__ "\033[33;1m"
#define __WHITE__ "\033[0m"
#endif
#endif
 
#if defined _WINDEBUG || defined _LINUXDEBUG
#define ar2vec(_begin, _end) \
    vector<decay<iterator_traits<decltype(_begin)>::value_type>::type>(_begin, _end)
#define debug(x...) \
    do { cout << __YELLOW__ << #x << " -> "; err(x); } while(0)
void err() { cout << __WHITE__ << endl; }
template<typename T, typename... A>
void err(T a, A... x) { cout << __RED__ << a << __YELLOW__ << ' '; err(x...); }
template<template<typename...> class T, typename t, typename... A>
void err(T<t> a, A... x) { for(auto& v : a) cout << __RED__ << v << __YELLOW__ << ' '; err(x...); }
#else
#define ar2vec(...)
#define debug(...)
#endif
/*************************************************************/

string getsub(string &s) {
    int n = s.length();
    for(int i = 1; i <= n; i++) {
        if(n % i) continue;

        string sub = s.substr(0, i);
        bool flag = true;
        for(int j = i; j < n; j += i) {
            if(sub != s.substr(j, i)) {
                flag = false;
                break;
            }
        }
        if(flag)
            return sub;
    }
    return string("");
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(0);
    // freopen("test.in", "r", stdin);
    // freopen("test.out", "w", stdout);

    int q = 0;
    cin >> q;
    while(q--) {
        string s, t;
        cin >> s >> t;

        string s_sub = getsub(s);
        string t_sub = getsub(t);

        debug(s_sub);
        debug(t_sub);
        
        if(s_sub != t_sub)
            cout << -1 << endl;
        else {
            int s_num = s.length() / s_sub.length();
            int t_sum = t.length() / t_sub.length();
            int lcd = s_num * t_sum / __gcd(s_num, t_sum);
            debug(s_num, t_sum, lcd);
            
            for(int i = 1; i < lcd; i++)
                s_sub += t_sub;
            cout << s_sub << endl;
        }
    }

    return 0;
}
```

## C. [No More Inversions](https://codeforces.com/contest/1473/problem/C)

### Description ###

> Time Limit: 2 seconds
> Memory Limit: 256 megabytes

You have a sequence $a$ with $n$ elements $1, 2, 3, \dots, k - 1, k, k - 1, k - 2, \dots, k - (n - k)$ ($k \le n < 2k$).

Let's call as inversion in $a$ a pair of indices $i < j$ such that $a[i] > a[j]$.

Suppose, you have some permutation $p$ of size $k$ and you build a sequence $b$ of size $n$ in the following manner: $b[i] = p[a[i]]$.

Your goal is to find such permutation $p$ that the total number of inversions in $b$ doesn't exceed the total number of inversions in $a$, and $b$ is *lexicographically maximum* .

Small reminder: the sequence of $k$ integers is called a permutation if it contains all integers from $1$ to $k$ exactly once.

Another small reminder: a sequence $s$ is *lexicographically smaller* than another sequence $t$, if either $s$ is a prefix of $t$, or for the first $i$ such that $s_i \ne t_i$, $s_i < t_i$ holds (in the first position that these sequences are different, $s$ has smaller number than $t$).

#### Input ####

The first line contains a single integer $t$ ($1 \le t \le 1000$) — the number of test cases.

The first and only line of each test case contains two integers $n$ and $k$ ($k \le n < 2k$; $1 \le k \le 10^5$) — the length of the sequence $a$ and its maximum.

It's guaranteed that the total sum of $k$ over test cases doesn't exceed $10^5$.

#### Output ####

For each test case, print $k$ integers — the permutation $p$ which maximizes $b$ lexicographically without increasing the total number of inversions.

It can be proven that $p$ exists and is unique.

#### Example ####

##### Input #####

```
4
1 1
2 2
3 2
4 3
```

##### Output #####

```
1 
1 2 
2 1 
1 3 2 
```

#### Note ####

In the first test case, the sequence $a = [1]$, there is only one permutation $p = [1]$.

In the second test case, the sequence $a = [1, 2]$. There is no inversion in $a$, so there is only one permutation $p = [1, 2]$ which doesn't increase the number of inversions.

In the third test case, $a = [1, 2, 1]$ and has $1$ inversion. If we use $p = [2, 1]$, then $b = [p[a[1]], p[a[2]], p[a[3]]] = [2, 1, 2]$ and also has $1$ inversion.

In the fourth test case, $a = [1, 2, 3, 2]$, and since $p = [1, 3, 2]$ then $b = [1, 3, 2, 3]$. Both $a$ and $b$ have $1$ inversion and $b$ is the lexicographically maximum.

### Solution

考虑到 $a$ 中的逆序列数目共有 $\sum\limits_{i=1}^{n-k} = \dfrac{(n-k)(n-k+1)}{2}$ 个，全部由序列的后半部分 $k,(k-1),\cdots,k-(n-k)$ 所贡献，因此只需要保证 $b$ 中的逆序列构造方式和 $a$ 相同即可。

因此构造 $p = [1, 2, \cdots, (2k-n-1),k,(k-1),\cdots,k-(n-k)]$ 即可。容易发现 $b$ 序列中的逆序列部分和 $p$ 相同。

### Code

```c++
/*************************************************************/
#if __cplusplus < 201103L
    // For jury which unsupports C++11
 
#include <cstdio>
#include <cstring>
#include <cmath>
#include <cassert>
#include <iostream>
#include <algorithm>
#include <set>
#include <map>
#include <vector>
#include <string>
#include <queue>
using namespace std;
 
#define ffor(_var, _begin, _end, ...) \
    for(__typeof__(_end) _var = _begin; _var < _end; __VA_ARGS__)
#define rfor(_var, _rbegin, _rend, ...) \
    for(__typeof__(_rbegin) _var = _rbegin; _var > _rend; __VA_ARGS__)
#define cfor(_var, _cbegin, _cend, ...) \
    for(__typeof__(_cend) _var = _cbegin; _var != _cend; __VA_ARGS__)
 
#else
 
#include <bits/stdc++.h>
using namespace std;
 
#define ffor(_var, _begin, _end, ...) \
    for(decay<decltype(_end)>::type _var = _begin; _var < _end; __VA_ARGS__)
#define rfor(_var, _rbegin, _rend, ...) \
    for(decay<decltype(_rbegin)>::type _var = _rbegin; _var > _rend; __VA_ARGS__)
 
#endif
 
typedef long long ll;
typedef long double ld;
#define ABS(x) ((x) > 0 ? (x) : -(x))

const int INF = 0x3f3f3f3f;
 
// #define __DEBUG__
 
#ifdef __DEBUG__
#if defined _WIN32
#define _WINDEBUG
#include <windows.h>
inline std::ostream& __YELLOW__(std::ostream &s) {
    HANDLE hStdout = GetStdHandle(STD_OUTPUT_HANDLE); 
    SetConsoleTextAttribute(hStdout, 
         FOREGROUND_GREEN|FOREGROUND_RED|FOREGROUND_INTENSITY);
    return s;
}
inline std::ostream& __WHITE__(std::ostream &s) {
    HANDLE hStdout = GetStdHandle(STD_OUTPUT_HANDLE); 
    SetConsoleTextAttribute(hStdout, 
       FOREGROUND_RED|FOREGROUND_GREEN|FOREGROUND_BLUE);
    return s;
}
inline std::ostream& __RED__(std::ostream &s)
{
    HANDLE hStdout = GetStdHandle(STD_OUTPUT_HANDLE); 
    SetConsoleTextAttribute(hStdout, 
                FOREGROUND_RED|FOREGROUND_INTENSITY);
    return s;
}
#elif defined __linux__
#define _LINUXDEBUG
#define __YELLOW__ "\033[33;1m"
#define __WHITE__ "\033[0m"
#endif
#endif
 
#if defined _WINDEBUG || defined _LINUXDEBUG
#define ar2vec(_begin, _end) \
    vector<decay<iterator_traits<decltype(_begin)>::value_type>::type>(_begin, _end)
#define debug(x...) \
    do { cout << __YELLOW__ << #x << " -> "; err(x); } while(0)
void err() { cout << __WHITE__ << endl; }
template<typename T, typename... A>
void err(T a, A... x) { cout << __RED__ << a << __YELLOW__ << ' '; err(x...); }
template<template<typename...> class T, typename t, typename... A>
void err(T<t> a, A... x) { for(auto& v : a) cout << __RED__ << v << __YELLOW__ << ' '; err(x...); }
#else
#define ar2vec(...)
#define debug(...)
#endif
/*************************************************************/

const int MAXN = 1e5;
int p[MAXN + 10];

int main() {
    ios::sync_with_stdio(false);
    cin.tie(0);
    // freopen("test.in", "r", stdin);
    // freopen("test.out", "w", stdout);

    int t = 0;
    cin >> t;
    while(t--) {
        int n = 0, k = 0;
        cin >> n >> k;

        for(int i = 1; i <= 2 * k - n - 1; i++)
            p[i] = i;
        for(int i = 2 * k - n, cnt = k; i <= k; i++)
            p[i] = cnt--;
        for(int i = 1; i <= k; i++)
            if(i == k) cout << p[i] << endl;
            else cout << p[i] << " ";
    }

    return 0;
}
```

## D. [Program](https://codeforces.com/contest/1473/problem/D)

### Description ###

> Time Limit: 2 seconds
> Memory Limit: 256 megabytes

You are given a program that consists of $n$ instructions. Initially a single variable $x$ is assigned to $0$. Afterwards, the instructions are of two types:

- increase $x$ by $1$;
- decrease $x$ by $1$.

You are given $m$ queries of the following format:

- query $l$ $r$ — how many distinct values is $x$ assigned to if all the instructions between the $l$-th one and the $r$-th one inclusive are ignored and the rest are executed without changing the order?

#### Input ####

The first line contains a single integer $t$ ($1 \le t \le 1000$) — the number of testcases.

Then the description of $t$ testcases follows.

The first line of each testcase contains two integers $n$ and $m$ ($1 \le n, m \le 2 \cdot 10^5$) — the number of instructions in the program and the number of queries.

The second line of each testcase contains a program — a string of $n$ characters: each character is either '$\texttt{+}$' or '$\texttt{-}$' — increment and decrement instruction, respectively.

Each of the next $m$ lines contains two integers $l$ and $r$ ($1 \le l \le r \le n$) — the description of the query.

The sum of $n$ over all testcases doesn't exceed $2 \cdot 10^5$. The sum of $m$ over all testcases doesn't exceed $2 \cdot 10^5$.

#### Output ####

For each testcase print $m$ integers — for each query $l$, $r$ print the number of distinct values variable $x$ is assigned to if all the instructions between the $l$-th one and the $r$-th one inclusive are ignored and the rest are executed without changing the order.

#### Example ####

##### Input #####

```
2
8 4
-+--+--+
1 8
2 8
2 5
1 1
4 10
+-++
1 1
1 2
2 2
1 3
2 3
3 3
1 4
2 4
3 4
4 4
```

##### Output #####

```
1
2
4
4
3
3
4
2
3
2
1
2
2
2
```

#### Note ####

The instructions that remain for each query of the first testcase are:

1. empty program — $x$ was only equal to $0$;
2. "$\texttt{-}$" — $x$ had values $0$ and $-1$;
3. "$\texttt{---+}$" — $x$ had values $0$, $-1$, $-2$, $-3$, $-2$ — there are $4$ distinct values among them;
4. "$\texttt{+--+--+}$" — the distinct values are $1$, $0$, $-1$, $-2$.

### Solution

首先考虑到在一段连续的指令序列中，$x$ 的赋值序列是连续的；这是因为每条指令只能为 $x$ 加 $1$ 或者减 $1$。因此，只需要维护该段指令序列中 $x$ 的最大值和最小值。

考虑维护一个如下的数据结构：

```c++
struct Data {
    int maxx, minn, add;
    
    Data(int _max = 0, int _min = 0, int _add = 0):
        maxx(_max), minn(_min), add(_add) {}
    Data operator + (const Data &d) {
        return Data(max(maxx, add + d.maxx), min(minn, add + d.minn),
                    add + d.add);
    }
};
#endif
```

其中 `maxx` 和 `minn` 分别为在指令序列此处 $x$ 的最大值和最小值，`add` 代表
