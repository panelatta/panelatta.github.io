---
author: Panelatta
categories:
- Math
- Convex Optimization
cid: 212
date: '2019-08-21T20:31:00+08:00'
layout: post
mathjax: true
status: publish
tags: null
title: The Method of Lagrangian Multipliers and The KKT Conditions
updated: 2019-08-21 20:34:47
---

This article simply introduced strategies for finding the stationary points of the objective function subject to one or more equality or inequality constraints. 

Consider a standard form of continuous optimization problem,
$$
\min\limits_{\bf x} f({\bf x}) \\
{\rm s.t.}\;\;g_k({\bf x})\leq0,\;\;k=1,2,\cdots,m \\
h_l({\bf x})=0,\;\;l=1,2,\cdots,p \\
$$
in which
$$
{\bf x} \in \Re^{n} \\
f,g_k,h_l:\Re^n \rightarrow \Re\;\;{\rm for}\;\;k=1,2,\cdots,m\;\;{\rm and}\;\;l=1,2,\cdots,p \\
m,p\geq0
$$
And $f,g_k,h_l$ are all continuous differentable.

We divided the problem into two cases: $p = 0$ or $p \neq 0$. For the former we introduced **The Method of Lagrange Multipliers** as the solving strategy, and simply introduced **KKT Conditions** for the other one when it suits some **Regularity Conditions**. 

Notice that it was easy to treat a maximization problem by negating the objective function, we only use the maximization problem as a general example. 

<!--more-->

## The Method of Lagrange Multipliers

Consider the optimization problem
$$
\min_{\bf x}f({\bf x}) \\
{\rm s.t.}\;\;g_k({\bf x})=0\;\;{\rm for}\;\;k=1,2,\cdots,m.
$$
To transfer the constrained problem into an unconstrained one, we define the **Lagrange Function**,
$$
L({\bf x, \overrightarrow{\lambda}})=f({\bf x})+\sum_{k=1}^m \lambda_k g_k({\bf x})
$$
In which $\lambda_{k} \in \Re \;\; {\rm for} \;\; k=1,2,\cdots,m$. Then we have the **necessary conditions** for the optimal solution, which is
$$
\left\{\begin{matrix}
\bigtriangledown_{\bf x}L={\bf 0} \\
\bigtriangledown_{\bf \overrightarrow{\lambda}}L={\bf 0}
\end{matrix}\right.
$$
called **Stationary Equation** and **Constraints** separately. Then solving the $n+m$ simultaneous equations, and the solution $({\bf x^*},\overrightarrow{\lambda}\!^*)$ are stationary points and corresponding coefficients.

${\bf N{\scriptsize OTE}}.$   *Cause we could get stationary point through Lagrange Multipliers directly, the minimization/maximization problems are treated in same way.*

${\bf E{\scriptsize XAMPLE}}.$   Maximize $f(x,y,z) = 8xyz$  subject to $\dfrac{x^2}{a^2}+\dfrac{y^2}{b^2}+\dfrac{z^2}{c^2}=1$.

${\bf S{\scriptsize OLUTION}}.$   Form the Lagrange Function
$$
L(x,y,z,\lambda)=8xyz+\lambda(\dfrac{x^2}{a^2}+\dfrac{y^2}{b^2}+\dfrac{z^2}{c^2}-1)
$$
Then calculate gradient of the function $L$ and set it to $\bf 0$.
$$
\bigtriangledown L=\begin{bmatrix} (8yz+\dfrac{2\lambda x}{a^2}) & (8xz+\dfrac{2\lambda y}{b^2}) & (8xy+\dfrac{2\lambda z}{c^2}) & (\dfrac{x^2}{a^2}+\dfrac{y^2}{b^2}+\dfrac{z^2}{c^2}-1) \end{bmatrix} = {\bf 0}
$$
We could get the solution
$$
\left\{\begin{matrix}
x=\dfrac{\sqrt{3}}{3}a \\
y=\dfrac{\sqrt{3}}{3}b \\
z=\dfrac{\sqrt{3}}{3}c \\
\end{matrix}\right.
$$
Considering the background of the question, the maximum solution must exist. Now we can get the answer
$$
f_{\rm max}(x,y,z)=\dfrac{8\sqrt{3}}{9}abc
$$

## KKT Conditions

For convinience, we consider the case without equality constraint but with a single inequality constraint first,
$$
\min_{\bf x}f({\bf x}) \\
{\rm s.t.} \;\; g({\bf x}) \leq 0.
$$
Then define the **feasible region** $\mathbb{K}=\left\{ \Re^n\,|\,g({\bf x}) \leq 0 \right\}$ and assuming that ${\bf x}^*$ is the best solution under the constraint condition $g$. According to whether ${\bf x}^*$ is on the border of $\mathbb{K}$ or not, we can divide the problem into two cases and discuss them separately.

${\bf C{\scriptsize ASE}\; 1}.\;\; g({\bf x}^*) <0.$ The *best* solution is inside $\mathbb{K}$. At this time we call ${\bf x}^*$ as the **interior solution**. Obviously, at this time, an infinitesimal displacement of the point towards any direction will not against the constraint, so we call that the constraint condition$g$ is **inactive**.

${\bf C{\scriptsize ASE}\;2}.\;\;g({\bf x}^*)=0.$ The *best* solution is on the border of $\mathbb{K}$. At this time we call ${\bf x}^*$ as the **boundary solution**. Correspondingly, now we call that the constraint condition $g$ is **active**.

Likely, defining the Lagrangian Function
$$
L({\bf x},\lambda)=f({\bf x})+\lambda g({\bf x})
$$
According to $g$ is *active* or *inactive*, the necessary condition for us to get the *best* solution are different.

${\bf C{\scriptsize ASE}\;I{\scriptsize NACTIVE}}. $Cause the constraint condition $g$ has no influence on getting the *best* solution, we could make $\lambda = 0$ directly. Now the task is equivalent to *unconstrained optimization*, and only $\bigtriangledown f={\bf 0}$ is needed.

${\bf C{\scriptsize ASE} \; A{\scriptsize CTIVE}}.$ Now the constraint condition $g$ is equivalent to 
$$
g({\bf x})=0
$$
Notice that for every points ${\bf x} \in g$, there is $\bigtriangledown g({\bf x})$ orthogonal to $g$. Likely, it is obvious to find that $\bigtriangledown f({\bf x}^*)$ is also orthogonal to $g$. So, we can easily prove that $\bigtriangledown f \in {\rm span}(\bigtriangledown g)$ at ${\bf x}^*$. That is to say, there exists $\lambda$ which makes that
$$
\bigtriangledown_{\bf x} f=-\lambda \bigtriangledown_{\bf x} g
$$
It's easy to find that $\lambda \geq 0$ should be kept, cause we want to minimize $f$, and $\bigtriangledown f({\bf x}^*)$ (pointing to the fastest growing direction) should point to the interior of $\mathbb{K}$. However, $\bigtriangledown g$ points to the outside of $\mathbb{K}$, so $\lambda$ should be kept not less than$0$, which is called **dual feasibility**. Likely, if we want to maximize $f$, we should keep $\lambda \leq 0$.

Obviously, there will always be either $\lambda$ or $g$ equal to $0$, so it always holds that $\lambda g({\bf x})=0$, which is called **complementary slackness**. 

Thus we can summarize all necessary conditions mentioned above as **KKT Conditions**,

$$
\begin{aligned}
\bigtriangledown_{\bf x} f + \lambda \bigtriangledown_{\bf x} g &= {\bf 0} \\
{\bf g}({\bf x}) &\leq 0 \\
\lambda &\geq 0 \\
\lambda g({\bf x}) &= 0
\end{aligned}
$$

Similarly, we can also extend the conclusion to the general continuous optimization problem. The corresponding Lagrangian Function is defined as
$$
L({\bf x}, \overrightarrow \lambda, \overrightarrow \mu)=f({\bf x})+\overrightarrow \lambda\!^\top {\bf g}({\bf x}) + \overrightarrow \mu\!^\top {\bf h}({\bf x})
$$
And it's also convinient to write down the corresponding KKT Conditions
$$
\begin{aligned}
\bigtriangledown_{\bf x} f + \overrightarrow \lambda\!^\top \bigtriangledown_{\bf x}{\bf g}+\overrightarrow \mu\!^\top\bigtriangledown_{\bf x}{\bf h} &= {\bf 0} \\
g_k({\bf x}) &\leq 0, \;\; k=1,2,\cdots, m \\
h_l({\bf x}) &= 0, \;\; l=1,2,\cdots, p \\
\lambda_k &\geq 0,\\
\lambda_k g_k({\bf x}) &= 0
\end{aligned}
$$

> ${\bf N{\scriptsize OTE}}.$ In order for existing a point ${\bf x}^*$ fitting the KKT Conditions, The primal question should satisfy some regular conditions, which has been listed on [Wikipedia](https://en.wikipedia.org/wiki/Karush–Kuhn–Tucker_conditions#Regularity_conditions_(or_constraint_qualifications)).

${\bf E{\scriptsize XAMPLE}}.$   Minimize $x_1^2 + x_2^2$ subject to $x_1 + x_2=1$ and $x_2 \leq \alpha$, in which $x_1, x_2, \alpha \in \Re$.

${\bf S{\scriptsize OLUTION}}.$   The corresponding Langrangian Function is
$$
L({\bf x}, \lambda, \mu)=x_1^2 + x_2^2 +\lambda(x_2-\alpha)+\mu(x_1 + x_2 - 1)
$$
According to KKT Condition, there must be
$$
\left \{
\begin{aligned}
\frac{\partial L}{\partial x_1} = \frac{\partial L}{\partial x_2} &= 0 \\
x_1 + x_2 &= 1 \\
x_2 &\leq \alpha \\
\lambda &\geq 0 \\
\lambda(x_2 - \alpha) &= 0
\end{aligned}
\right.
$$
which is equivalent to
$$
\left \{
\begin{aligned}
x_1 &= -\frac{\mu}{2} \\
x_2 &= \frac{\mu}{2} + 1 \\
\mu &\leq -1 \\
\mu &\leq 2\alpha - 2 
\end{aligned}
\right.
$$
Now we can divide the problem into 2 cases according to whether $2\alpha - 2 \geq -1$ or not.

${\bf C{\scriptsize ASE}}\;\;\alpha \geq \dfrac{1}{2}.$   It is easy to verify that $\mu = -1$ satisfies all KKT Conditions above, so when $x_1 = x_2 = \dfrac{1}{2}$, $x_1^2 + x_2^2$ takes minimum value $\dfrac{1}{2}$.

${\bf C{\scriptsize ASE}}\;\;\alpha < \dfrac{1}{2}.$   There is $\mu=2\alpha - 2$ satisfies all KKT Conditions above only, so when $x_1=1-\alpha$and$x_2 = \alpha$, $x_1^2 + x_2^2$ takes minimum value $1 - 2\alpha + 2\alpha^2$.
