---
author: Panelatta
categories:
- Math
- Convex Optimization
cid: 245
date: '2019-09-17T19:26:00+08:00'
layout: post
mathjax: true
status: publish
tags: null
title: Differences Towards the Four Constrained Optimization Methods
updated: 2019-09-17 19:34:10
---

These four constrained optimization methods looks similarly when first seen:

- Lagrange Multipliers
- Penalty Methods
- Augmented Lagrangian Methods
- Merit Methods

Here is a comprehensive explaination towards these four methods written by [Brian Borchers](https://math.stackexchange.com/questions/2585712/merit-function-vs-largrange-functions-vs-penalty-funcitons).

<!--more-->

> No, they're not all the same and it's important to understand the differences between them.
>
> Start with a simple optimization problem
> $$
> {\rm min}\,f({\bf x})
> $$
> subject to
> $$
> {\bf g}({\bf x})=0
> $$
> where we can assume for simplicity that $f$ and $g$ are smooth (at least twice continously differentiable.)
>
> The Lagrangian function is
> $$
> L({\bf x},\boldsymbol{\lambda})=f({\bf x})+\boldsymbol{\lambda}^\top {\bf g}({\bf x})
> $$
> Note that $L$ is a function of ${\bf x}$ and $\boldsymbol{\lambda}$. The first order necessary condition for a point ${\bf x}^*$ to be a minimizer is that there is a $\boldsymbol{\lambda}^*$ such that $({\bf x}^*,\boldsymbol{\lambda}^*)$ is a stationary point of $L$. In the method of multipliers, we try to solve the nonlinear system of equations
> $$
> \nabla_{\bf x}L={\bf 0} \\\nabla_{\boldsymbol{\lambda}}L={\bf 0}
> $$
> This is typically done by alternately minimizing with respect to $\bf x$ and updating $\boldsymbol{\lambda}$. Given a Lagrange multiplier estimate $\boldsymbol{\lambda}^{(k)}$, we minimize $L({\bf x},\boldsymbol{\lambda}^{(k)})$ to get ${\bf x}^{(k)}$. Then we update $\boldsymbol{\lambda}$ with
> $$
> \boldsymbol\lambda^{(k+1)}=\boldsymbol\lambda^{(k)}+\alpha_k {\bf g}({\bf x}^k)
> $$
> Where $\alpha_k$ is a step size parameter that can be set in various ways.
>
> An penalty function for our problem is a function that is $0$ if ${\bf g}({\bf x})={\bf 0}$ and greater than $\bf 0$ when ${\bf g}({\bf x}) \neq \bf 0$. A commonly used penalty function is the quadratic penalty function
> $$
> \phi({\bf g}({\bf x}))={\bf g}^2 ({\bf x})
> $$
> In the penalty function method, we solve an unconstrained problem of the form
> $$
> {\rm min}\, f({\bf x})+\boldsymbol\rho^\top\phi({\bf g}({\bf x}))
> $$
> where $\boldsymbol \rho$ is a penalty parameter that is increased until the solution of the penalized problem is close to satisfying ${\bf g}({\bf x})={\bf 0}$. Note that $\boldsymbol \rho$ is not a Lagrange multiplier in this case.
>
> For problems with inequality constraints a commonly used penalty function is
> $$
> \phi({\bf g}({\bf x})) = \left({\rm max} \left\{ 0, {\bf g}({\bf x}) \right\}\right)^2
> $$
> An augmented Lagrangian function combines the penalty function idea with the Lagrangian:
> $$
> \hat L({\bf x},\boldsymbol\lambda, \boldsymbol\rho)=f({\bf x})+\boldsymbol\lambda^\top{\bf g}({\bf x})+\boldsymbol\rho^\top\phi({\bf g}({\bf x}))
> $$
> Augmented Lagrangian methods minimize $\hat L$ with respect to $\bf x$, update the Lagrange multiplier estimate $\boldsymbol \lambda$ and then (if necessary) update the penalty parameter $\boldsymbol\rho$ in each iteration. In practice, augmented Lagrangian methods outperform simple penalty methods and the method of multipliers.
>
> Merit functions are used in a variety of nonlinear programming algorithms. You'll most commonly see them used in sequential quadratic programming methods. In these methods, a search direction, ${\bf d}^{(k)}$, is computed at each iteration. The step is from ${\bf x}^{(k)}$ to
> $$
> {\bf x}^{(k+1)}={\bf x}^{(k)}+\alpha_k {\bf d}^{(k)}
> $$
> where the step size parameter $\alpha_k$ is determined by minimizing a merit function
> $$
> \alpha_k = {\rm arg}\min_\alpha M({\bf x}^{(k)}+\alpha{\bf d}^{(k)})
> $$
> The merit function is typically something like a penalized objective function or an augmented Lagrangian, but there's a great deal of freedom in the form of the merit function.
>
> These functions and the associated methods are described in many textbooks on nonlinear optimization. A good discussion can be found in [Numerical Optimization by Nocedal and Wright.](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.702.5713&rep=rep1&type=pdf)
