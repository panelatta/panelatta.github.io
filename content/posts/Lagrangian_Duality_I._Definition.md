---
categories:
- Math
- Convex Optimization
date: '2019-10-28T20:48:00+08:00'
mathjax: true
tags: null
title: Lagrangian Duality I. Definition
updated: 2019-10-28 21:29:14
---

考虑原始 Constrained Optimization Problem

$$
\begin{aligned}
&\min\; f({\bf x}) \\
{\rm s.t.}\;\;c_i({\bf x}) &\leq 0, \; i=1,2,\cdots,n \\
h_j({\bf x}) &= 0, \; j = 1,2,\cdots,m\\
\end{aligned}
\tag{1}
$$

其 Lagrangian 形式为

$$
\mathcal{L}({\bf x}, \boldsymbol{\alpha},\boldsymbol{\beta})=f({\bf x})+\boldsymbol{\alpha}^\top {\bf c}({\bf x})+\boldsymbol{\beta}^\top{\bf h}({\bf x})
$$

<!--more-->

为了最小化 $\mathcal{L}({\bf x}, \boldsymbol{\alpha}, \boldsymbol{\beta})$，考虑函数

$$
\theta_P=\max_{\boldsymbol{\alpha}, \boldsymbol{\beta}}\mathcal{L}({\bf x}, \boldsymbol{\alpha}, \boldsymbol{\beta}) \\
{\rm s.t.}\;\; \alpha_i \geq 0,\;i=1,2,\cdots,n
$$

则有

$$
\theta_P(\boldsymbol{\alpha}, \boldsymbol{\beta}) = 
\begin{cases}
    f(\mathbf{x}) 
        &\begin{cases}
            c_i(\mathbf{x}) \leq 0 &i = 1,2,\cdots,n \\
            h_j(\mathbf{x}) = 0 &j = 1,2,\cdots,m
        \end{cases} \\
    \infty &\text{others}
\end{cases}
$$

> ${\bf P{\scriptsize ROOF}.}$若 $\exists\, i\in[1:n]$使得 $c_i({\bf x})\geq0$，则可调整 $\alpha_i$使 $\theta_P \rightarrow +\infty$；同理，若 $\exists\, j \in [1:m]$ 使得$h_j({\bf x}) \neq 0$，则可调整$\beta_j h_j({\bf x})$ 使得$\theta_P \rightarrow +\infty$。$\blacksquare$

因此，$(1)$ 的最优解为

$$
p^* = \min_{\bf x}f({\bf x}) = \min_{\bf x}\max_{\boldsymbol{\alpha},\boldsymbol{\beta}}\mathcal{L}({\bf x},\boldsymbol{\alpha},\boldsymbol{\beta}) \\
{\rm s.t.}\;\; \alpha_i \geq 0,\; i=1,2,\cdots,n
$$

现在，为了逐步逼近 $p^*$，考虑找到 $(1)$ 的一个足够好的下界；注意到当方程组

$$
\left\{
\begin{aligned}
f({\bf x}) &< d^* \\
{\bf c}({\bf x}) &\leq {\bf 0} \\
{\bf h}({\bf x}) &= {\bf 0}
\end{aligned}
\right.
\tag{2}
$$

无解时，$d^*$是 $p^*$ 的一个下界。同时，$(2)$ 有解当且仅当对$\forall \boldsymbol{\alpha},\boldsymbol{\beta}$ 均有

$$
f({\bf x})+\boldsymbol{\alpha}^\top {\bf c}({\bf x})+\boldsymbol{\beta}^\top{\bf h}({\bf x}) < d^*
\tag{3}
$$

同时 $(3)$无解的充要条件是$\exists\boldsymbol{\alpha '},\boldsymbol{\beta '}$ 使得

$$
\min_{\bf x} \left( f({\bf x})+\boldsymbol{\alpha '}^\top{\bf c}({\bf x})+\boldsymbol{\beta '}^\top{\bf h}({\bf x}) \right) \geq d^*
$$

由此，为了获得足够好的下界，可将上式取最大值

$$
\begin{aligned}
d^* &= \max_{\boldsymbol{\alpha},\boldsymbol{\beta}}\min_{\bf x} \left( f({\bf x})+\boldsymbol{\alpha}^\top{\bf c}({\bf x})+\boldsymbol{\beta}^\top{\bf h}({\bf x}) \right) \\
&= \max_{\boldsymbol{\alpha},\boldsymbol{\beta}}\min_{\bf x}\mathcal{L}({\bf x}, \boldsymbol{\alpha}, \boldsymbol{\beta})
\end{aligned}
\tag{4}
$$

注意到 $d^*$与 $p^*$对$\mathcal{L}({\bf x}, \boldsymbol{\alpha}, \boldsymbol{\beta})$ 取最值的顺序恰好相反，称$d^*$ 对应的问题是原问题的 Dual Problem。至此，引入函数

$$
\theta_D({\bf x}) = \max_{\boldsymbol{\alpha},\boldsymbol{\beta}}\mathcal{L}({\bf x}, \boldsymbol{\alpha}, \boldsymbol{\beta})
$$

定义 Dual Lagrangian 函数及其最优解

$$
d^* = \max_{\boldsymbol{\alpha},\boldsymbol{\beta}}\min_{\bf x}\mathcal{L}({\bf x}, \boldsymbol{\alpha}, \boldsymbol{\beta}) \\
{\rm s.t.}\;\; \boldsymbol{\alpha} \geq {\bf 0}
$$

此时，给出如下定理：

${\bf T{\scriptsize HEOREM}\;1}.\;\;{\rm W{\scriptsize EAK}\;D{\scriptsize UALITY}.}$

假设 $p^*$与$d^*$ 均存在，则

$$
\boxed{d^* \leq p^*.}
$$

${\bf P{\scriptsize ROOF}}.$ 易得

$$
\min_{\bf x}\mathcal{L}({\bf x}, \boldsymbol{\alpha}, \boldsymbol{\beta}) \leq ({\bf x}, \boldsymbol{\alpha}, \boldsymbol{\beta}) \leq \max_{\boldsymbol{\alpha},\boldsymbol{\beta}}\mathcal{L}({\bf x}, \boldsymbol{\alpha}, \boldsymbol{\beta})
$$

则有

$$
\begin{aligned}
d^* &= \max_{\boldsymbol{\alpha},\boldsymbol{\beta}}\min_{x}\mathcal{L}({\bf x}, \boldsymbol{\alpha}, \boldsymbol{\beta}) \\
&\leq \min_{\bf x}\max_{\boldsymbol{\alpha},\boldsymbol{\beta}}\mathcal{L}({\bf x}, \boldsymbol{\alpha}, \boldsymbol{\beta}) \\
&= p^*\;\blacksquare
\end{aligned}
$$

此时称 $(p^* - d^*)$ 为 Duality Gap.

> ${\bf N\scriptsize{OTE}}.$ 注意 Weak Duality 实际上对于一切优化问题均成立，而与原始问题是否为凸无关。

由此可给出如下引理：

${\bf C{\scriptsize OROLLARY}\;\;1}.$若 $p^*$与 $d^*$ 均存在且有$p^* = d^*$，则 Primal Problem 和 Dual Problem 的可行解$({\bf x}^*, \boldsymbol{\alpha}^*, \boldsymbol{\beta}^*)$ 分别也是对应问题的最优解。

因此，一旦 $p^* = d^*$成立，则可以经由计算 Dual Problem 来获得 Primal Problem 的解；称$p^* = d^*$ 为 Strong Duality。
