---
title: 编译原理（清华第3版）：第4章笔记
date: 2020-01-04 17:53:01
tags:
---

## LL(1)文法的判别

已知正则文法与DFA等价，可将语法分析器视作一个DFA；故由自动机的特性，期望在某一时刻只要获得有限个 token 的输入，便可据此判断应选用哪条产生式进行状态转移。当给定文法 $G$ 和字符串 $s$ 时，期望能从 $G$ 的开始符号开始构建一棵可推导出 $s$ 的语法树，称这一过程为自顶向下的语法分析，执行这一过程的语法分析器称为 LL 分析器；当某一时刻需要获得的 token 输入数目为 1 时，称为 LL(1) 分析器，可以此分析器进行分析的文法称为 LL(1) 文法。

为了确定一个文法是否是 LL(1) 文法，需要构造如下三个集合：

### FIRST 集

#### 定义

一个符号串 $\alpha \in \textbf{V}^{\star}$ 的 FIRST 集定义为
$$
\displaystyle{\mathtt{\text{FIRST}}}{\left(\alpha\right)}={\left\lbrace{a}{|}\alpha\to{a}\beta,\alpha,\beta\in{\mathbf{{{V}}}}^{\star},{a}\in{\mathbf{{{V}}}}_{{\mathtt{\text{T}}}}\right\rbrace}
$$
若 $ \displaystyle\alpha\to\epsilon $ , 则有
$$
\displaystyle{\mathtt{\text{FIRST}}}{\left(\alpha\right)}=\epsilon
$$
当 $ \displaystyle\alpha={A}_{{1}}{A}_{{2}}\cdots{A}_{{n}} $ 且 $\epsilon \notin \texttt{FIRST}(A_{[1:n-1]})$ , 则
$$
\displaystyle{\mathtt{\text{FIRST}}}{\left(\alpha\right)}={\bigcup_{{{i}={1}}}^{{{n}}}}{\left\lbrace{\mathtt{\text{FIRST}}}{\left({A}_{{i}}\right)}-{\left\lbrace\epsilon\right\rbrace}\right\rbrace}\cup{\left\lbrace\epsilon{\quad\text{if}\quad}{A}_{{n}}\to\epsilon\right\rbrace}
$$
当文法中含有右部以非终结符开始的产生式时，便无法通过某时刻的输入字符直接选择应该使用的产生式；此时，若文法中不含能够推导出 $\epsilon$ 的产生式，且对所有左部分别相同的产生式，其右部之 FIRST 集交集均为空，则仍可构造确定的自顶向下分析。

### FOLLOW 集



