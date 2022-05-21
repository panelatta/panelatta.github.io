---
categories:
- Programming Contest
- Codeforces
- Div. 3
date: '2021-01-08T15:18:13+08:00'
tags:
- Codeforces
- Div. 3
- 题解
title: 'Codeforces Round #690 (Div. 3) [Personal Summary]'
toc: true
---

这场比较水，最后三题值得关注一下。

## My Status

|  A   |  B   |  C   |  D   |  E1  |  E2  |  F   |
| :--: | :--: | :--: | :--: | :--: | :--: | :--: |
|  O   |  O   |  O   |  O   |  O   |  O   |  O   |

<!--more-->

## A. [Favorite Sequence](https://codeforces.com/contest/1462/problem/A) (800)

### Description ###

> Time Limit: 2 seconds
> Memory Limit: 256 megabytes

Polycarp has a favorite sequence $a[1 \dots n]$ consisting of $n$ integers. He wrote it out on the whiteboard as follows:

- he wrote the number $a_1$ to the left side (at the beginning of the whiteboard);
- he wrote the number $a_2$ to the right side (at the end of the whiteboard);
- then as far to the left as possible (but to the right from $a_1$), he wrote the number $a_3$;
- then as far to the right as possible (but to the left from $a_2$), he wrote the number $a_4$;
- Polycarp continued to act as well, until he wrote out the entire sequence on the whiteboard.

| ![](https://espresso.codeforces.com/cb8722f608b54c6bb30e3157ab5143a0b99ec00b.png) |
| :----------------------------------------------------------: |
| The beginning of the result looks like this (of course, if $n \ge 4$). |

For example, if $n=7$ and $a=[3, 1, 4, 1, 5, 9, 2]$, then Polycarp will write a sequence on the whiteboard $[3, 4, 5, 2, 9, 1, 1]$.

You saw the sequence written on the whiteboard and now you want to restore Polycarp's favorite sequence.

#### Input ####

The first line contains a single positive integer $t$ ($1 \le t \le 300$) — the number of test cases in the test. Then $t$ test cases follow.

The first line of each test case contains an integer $n$ ($1 \le n \le 300$) — the length of the sequence written on the whiteboard.

The next line contains $n$ integers $b_1, b_2,\ldots, b_n$ ($1 \le b_i \le 10^9$) — the sequence written on the whiteboard.

#### Output ####

Output $t$ answers to the test cases. Each answer — is a sequence $a$ that Polycarp wrote out on the whiteboard.

#### Example ####

##### Input #####

```
6
7
3 4 5 2 9 1 1
4
9 2 7 1
11
8 4 3 1 2 7 8 7 9 4 2
1
42
2
11 7
8
1 1 1 1 1 1 1 1
```

##### Output #####

```
3 1 4 1 5 9 2 
9 1 2 7 
8 2 4 4 3 9 1 7 2 8 7 
42 
11 7 
1 1 1 1 1 1 1 1 
```

#### Note ####

In the first test case, the sequence $a$ matches the sequence from the statement. The whiteboard states after each step look like this:

$[3] \Rightarrow [3, 1] \Rightarrow [3, 4, 1] \Rightarrow [3, 4, 1, 1] \Rightarrow [3, 4, 5, 1, 1] \Rightarrow [3, 4, 5, 9, 1, 1] \Rightarrow [3, 4, 5, 2, 9, 1, 1]$.

### Solution

直接模拟。

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

const int MAXN = 300;
int a[MAXN + 10], b[MAXN + 10];

int main() {
    // freopen("test.in", "r", stdin);
    // freopen("test.out", "w", stdout);
    ios::sync_with_stdio(false);
    cin.tie(0);

    int t = 0;
    while(cin >> t) {
        while(t--) {
            int n = 0;
            cin >> n;
            
            ffor(i, 1, n + 1, i++)
                cin >> b[i];
            
            int *l = &b[1], *r = &b[n];
            int m = 1;
            while(r - l >= 0) {
                a[m++] = *l;
                a[m++] = *r;
                l++; r--;
            }

            ffor(i, 1, n + 1, i++) {
                if(i == n) cout << a[i] << endl;
                else cout << a[i] << " ";
            }
        }
    }

    return 0;
}
```

## B. [Last Year's Substring](https://codeforces.com/contest/1462/problem/B) (800)

### Description ###

> Time Limit: 2 seconds
> Memory Limit: 256 megabytes

Polycarp has a string $s[1 \dots n]$ of length $n$ consisting of decimal digits. Polycarp performs the following operation with the string $s$ **no more than once** (i.e. he can perform operation $0$ or $1$ time): 

- Polycarp selects two numbers $i$ and $j$ ($1 \leq i \leq j \leq n$) and removes characters from the $s$ string at the positions $i, i+1, i+2, \ldots, j$ (i.e. removes substring $s[i \dots j]$). More formally, Polycarp turns the string $s$ into the string $s_1 s_2 \ldots s_{i-1} s_{j+1} s_{j+2} \ldots s_{n}$.

For example, the string $s=$"${\tt 20192020}$"​ Polycarp can turn into strings: 

- "$\tt 2020$" (in this case $(i,j)=(3,6)$ or $(i,j)=(1,4)$); 
- "$\tt 2019220$" (in this case $(i,j)=(6,6)$); 
- "$\tt 020$" (in this case $(i,j)=(1,5)$); 
- other operations are also possible, only a few of them are listed above.

Polycarp likes the string "$\tt 2020$" very much, so he is wondering if it is possible to turn the string s into a string "$\tt 2020$" in no more than one operation? Note that you can perform zero operations.

#### Input ####

The first line contains a positive integer $t$ ($1 \leq t \leq 1000 $) — number of test cases in the test. Then $t$ test cases follow.

The first line of each test case contains an integer $n$ ($4 \leq n \leq 200$) — length of the string $s$. The next line contains a string $s$ of length $n$ consisting of decimal digits. It is allowed that the string $s$ starts with digit $\tt 0$.

#### Output ####

For each test case, output on a separate line:

- "$\tt YES$" if Polycarp can turn the string $s$ into a string "$\tt 2020$" in no more than one operation (i.e. he can perform $0$ or $1$ operation); 
- "$\tt NO$" otherwise. 

You may print every letter of "$\tt YES$" and "$\tt NO$" in any case you want (so, for example, the strings $\tt yEs$, $\tt yes$, $\tt Yes$ and $\tt YES$ will all be recognized as positive answer).

#### Example ####

##### Input #####

```
6
8
20192020
8
22019020
4
2020
5
20002
6
729040
6
200200
```

##### Output #####

```
YES
YES
YES
NO
NO
NO
```

#### Note ####

In the first test case, Polycarp could choose $i=3$ and $j=6$.

In the second test case, Polycarp could choose $i=2$ and $j=5$.

In the third test case, Polycarp did not perform any operations with the string.

### Solution

检查字符串的前缀和后缀是否能拼成 $\tt 2020$ 即可。

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

const int MAXN = 300;
int a[MAXN + 10], b[MAXN + 10];

int main() {
    // freopen("test.in", "r", stdin);
    // freopen("test.out", "w", stdout);
    ios::sync_with_stdio(false);
    cin.tie(0);

    int t = 0;
    cin >> t;

    while(t--) {
        int n = 0;
        cin >> n;

        string s;
        cin >> s;

        bool flag = false;
        for(int i = 0; i <= 4; i++) {
            if(s.substr(0, i) + s.substr(n - 4 + i, 4 - i) == string("2020")) {
                flag = true;
                break;
            }
        }

        if(flag) cout << "YES" << endl;
        else cout << "NO" << endl;
    }

    return 0;
}
```

## C.  [Unique Number](https://codeforces.com/contest/1462/problem/C) (900)

### Description ###

> Time Limit: 2 seconds
> Memory Limit: 256 megabytes

You are given a positive number $x$. Find the smallest positive integer number that has the sum of digits equal to $x$ and all digits are **distinct** (unique).

#### Input ####

The first line contains a single positive integer $t$ ($1 \le t \le 50$) — the number of test cases in the test. Then $t$ test cases follow.

Each test case consists of a single integer number $x$ ($1 \le x \le 50$).

#### Output ####

Output $t$ answers to the test cases:

- if a positive integer number with the sum of digits equal to $x$ and all digits are different exists, print the smallest such number;
- otherwise print $\tt -1$.

#### Example ####

##### Input #####

```
4
1
5
15
50
```

##### Output #####

```
1
5
69
-1
```

### Solution

先检查 $x$ 是否大于 $45$，之后从 $9$ 到 $0$ 倒序贪心取数即可。

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

const int MAXN = 300;
int a[MAXN + 10], b[MAXN + 10];

int main() {
    // freopen("test.in", "r", stdin);
    // freopen("test.out", "w", stdout);
    ios::sync_with_stdio(false);
    cin.tie(0);

    int t = 0;
    cin >> t;

    while(t--) {
        int x = 0;
        cin >> x;
        
        if(x < 10) {
            cout << x << endl;
        } else if(x > 45) {
            cout << -1 << endl;
        } else {
            string ans;
            for(int i = 9; i >= 0 && x > 0; i--) {
                int add = 0;

                if(x >= i) add = i;
                else add = x;
                
                ans.push_back(add + '0');
                x -= add;
            }
            sort(ans.begin(), ans.end());
            cout << ans << endl;
        }
    }

    return 0;
}
```

## D. [Add to Neighbour and Remove](https://codeforces.com/contest/1462/problem/D) (1400)

### Description ###

> Time Limit: 3 seconds
> Memory Limit: 256 megabytes

Polycarp was given an array of $a[1 \dots n]$ of $n$ integers. He can perform the following operation with the array $a$ no more than $n$ times:

- Polycarp selects the index $i$ and adds the value $a_i$ to **one of his choice** of its neighbors. More formally, Polycarp adds the value of $a_i$ to $a_{i−1}$ or to $a_{i+1}$ (if such a neighbor does not exist, then it is impossible to add to it). 
- After adding it, Polycarp removes the $i$-th element from the $a$ array. During this step the length of $a$ is decreased by $1$.

The two items above together denote one single operation.

For example, if Polycarp has an array $a = [3, 1, 6, 6, 2]$, then it can perform the following sequence of operations with it:

- Polycarp selects $i = 2$ and adds the value $a_i$ to $(i-1)$-th element: $a = [4, 6, 6, 2]$.
- Polycarp selects $i = 1$ and adds the value $a_i$ to $(i+1)$-th element: $a = [10, 6, 2]$.
- Polycarp selects $i = 3$ and adds the value $a_i$ to $(i-1)$-th element: $a = [10, 8]$.
- Polycarp selects $i = 2$ and adds the value $a_i$ to $(i-1)$-th element: $a = [18]$.

Note that Polycarp could stop performing operations at any time.

Polycarp wondered how many minimum operations he would need to perform to make all the elements of $a$ equal (i.e., he wants all $a_i$ are equal to each other).

#### Input ####

The first line contains a single integer $t$ ($1 \leq t \leq 3000$) — the number of test cases in the test. Then $t$ test cases follow.

The first line of each test case contains a single integer $n$ ($1 \leq n \leq 3000$) — the length of the array. The next line contains $n$ integers $a_1, a_2, \ldots, a_n$ ($1 \leq a_i \leq 10^5$) — array $a$.

It is guaranteed that the sum of $n$ over all test cases does not exceed $3000$.

#### Output ####

For each test case, output a single number — the minimum number of operations that Polycarp needs to perform so that all elements of the $a$ array are the same (equal).

#### Example ####

##### Input #####

```
4
5
3 1 6 6 2
4
1 2 2 1
3
2 2 2
4
6 3 2 1
```

##### Output #####

```
4
2
0
2
```

#### Note ####

In the first test case of the example, the answer can be constructed like this (just one way among many other ways):

$[3, 1, 6, 6, 2]$ $\xrightarrow[]{i=4,~add~to~left}$ $[3, 1, 12, 2]$ $\xrightarrow[]{i=2,~add~to~right}$ $[3, 13, 2]$ $\xrightarrow[]{i=1,~add~to~right}$ $[16, 2]$ $\xrightarrow[]{i=2,~add~to~left}$ $[18]$. All elements of the array $[18]$ are the same.

In the second test case of the example, the answer can be constructed like this (just one way among other ways):

$[1, 2, 2, 1]$ $\xrightarrow[]{i=1,~add~to~right}$ $[3, 2, 1]$ $\xrightarrow[]{i=3,~add~to~left}$ $[3, 3]$. All elements of the array $[3, 3]$ are the same.

In the third test case of the example, Polycarp doesn't need to perform any operations since $[2, 2, 2]$ contains equal (same) elements only.

In the fourth test case of the example, the answer can be constructed like this (just one way among other ways):

$[6, 3, 2, 1]$ $\xrightarrow[]{i=3,~add~to~right}$ $[6, 3, 3]$ $\xrightarrow[]{i=3,~add~to~left}$ $[6, 6]$. All elements of the array $[6, 6]$ are the same.

### Solution

可以发现：假设问题存在一个操作次数为 $n - k$ 的解，则整段序列一定可被分解为 $k$ 段子序列，其中每段子序列和为 $(\sum\limits_{i=1}^n a[i]) / k$。之后直接模拟即可。

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

const int MAXN = 3000;
int a[MAXN + 10];

int main() {
    // freopen("test.in", "r", stdin);
    // freopen("test.out", "w", stdout);
    ios::sync_with_stdio(false);
    cin.tie(0);

    int t = 0;
    cin >> t;

    while(t--) {
        int n = 0;
        cin >> n;
        
        for(int i = 1; i <= n; i++)
            cin >> a[i];

        int sum = 0;
        for(int i = 1; i <= n; i++)
            sum += a[i];

        vector<int> div;
        for(int i = n; i >= 1; i--)
            if(!(sum % i))
                div.push_back(sum / i);
        
        for(auto &it : div) {
            bool flag = true;
            int seg_sum = 0;

            for(int i = 1; i <= n; i++) {
                seg_sum += a[i];
                if(seg_sum == it)
                    seg_sum = 0;
                else if(seg_sum > it) {
                    flag = false; break;
                }
            }
            
            if(!flag) continue;
            else {
                cout << n - (sum / it) << endl;
                break;
            }
        }
    }

    return 0;
}
```

## E1. [Close Tuples (easy version)](https://codeforces.com/contest/1462/problem/E1)
