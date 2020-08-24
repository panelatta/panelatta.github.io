---
title: Discriminative Correlation Filter Tracker with Channel and Spatial Reliability (CSR-DCF) 论文笔记
date: 2020-08-24 14:23:21
categories:
	- Visual Tracking
tags:
	- CSR-DCF
	- 论文笔记
---

## 公式推导

### 公式 (3) 的推导

> ${\bf N{\scriptsize OTE}}.$ 
>
> 原公式中后半部分的 $\lambda\sum\limits_{d=1}^{N_c}\left\|{\bf \hat{h}}\right\|_2^2$  似不正确，以下都修正为 $\lambda\sum\limits_{d=1}^{N_c}\left\|{\bf \hat{h}_d}\right\|_2^2$。

原公式为
$$
\begin{equation}
\begin{aligned}
\epsilon({\bf h}) &= \displaystyle{\left\|{{\sum_{{{d}={1}}}^{{{N}_{{c}}}}}{\rm diag}\left(\hat{{\mathbf{\text{f}}}}_{{d}}\right)\overline{\hat{{\mathbf{\text{h}}}}}_{{d}}-\hat{{\mathbf{\text{g}}}}}\right\|}^{2}_{2} + \displaystyle\lambda{\sum_{{{d}={1}}}^{{{N}_{{c}}}}}{\left\|\hat{{\bf h}}_d\right\|}^{2}_{2}\\
 &= \displaystyle{\left\|{{\sum_{{{d}={1}}}^{{{N}_{{c}}}}}\hat{{\mathbf{\text{f}}}}_{{d}}\odot\overline{\hat{{\mathbf{\text{h}}}}}_{{d}}-\hat{{\mathbf{\text{g}}}}}\right\|}^{2}_{2} + \displaystyle\lambda{\sum_{{{d}={1}}}^{{{N}_{{c}}}}}{\left\|\hat{{\bf h}}_d\right\|}^{2}_{2}
\end{aligned}
\end{equation}
$$


对 $\hat{{\bf h}}_d$ 进行求导：
$$
\begin{equation}
\begin{aligned}
{\rm d}\epsilon &= {\rm d}\left(\displaystyle{\left\|{{\sum_{{{d}={1}}}^{{{N}_{{c}}}}}\hat{{\mathbf{\text{f}}}}_{{d}}\odot\overline{\hat{{\mathbf{\text{h}}}}}_{{d}}-\hat{{\mathbf{\text{g}}}}}\right\|}^{2}_{2}\right) + {\rm d}\left(\displaystyle\lambda{\sum_{{{d}={1}}}^{{{N}_{{c}}}}}{\left\|{{\mathbf{\text{h}}}_{{d}}}\right\|}^{2}_{2}\right)
\end{aligned}
\end{equation}
$$

分别对两部分进行求导：

令 ${\bf c} = \displaystyle{{{\sum_{{{d}={1}}}^{{{N}_{{c}}}}}\hat{{\mathbf{\text{f}}}}_{{d}}\odot\overline{\hat{{\mathbf{\text{h}}}}}_{{d}}-\hat{{\mathbf{\text{g}}}}}}$，则
$$
\begin{equation}
\begin{aligned}
{\rm d}\left(\displaystyle{\left\|{{\sum_{{{d}={1}}}^{{{N}_{{c}}}}}\hat{{\mathbf{\text{f}}}}_{{d}}\odot\overline{\hat{{\mathbf{\text{h}}}}}_{{d}}-\hat{{\mathbf{\text{g}}}}}\right\|}^{2}_{2}\right) &= {\rm d}\left({\bf c}^{\rm H}{\bf c}\right) \\
&= \left({\rm d}{\bf c}\right)^{\rm H}{\bf c} + {\bf c}^{\rm H}{\rm d}{\bf c} \\
&= {\rm tr}\left({\bf c}^{\rm H}{\rm d}{\bf c}\right) \\
&= {\rm tr}\left(\overline{\bf c}^\top{\rm d}{\bf c}\right)
\end{aligned}
\end{equation}
$$
又
$$
\begin{equation}
\begin{aligned}
{\rm d}{\bf c} &= {\rm d}\left({{\sum_{{{d}={1}}}^{{{N}_{{c}}}}}\hat{{\mathbf{\text{f}}}}_{{d}}\odot\overline{\hat{{\mathbf{\text{h}}}}}_{{d}}-\hat{{\mathbf{\text{g}}}}}\right) \\
&= {\rm d}\left({{\sum_{{{d}={1}}}^{{{N}_{{c}}}}}\hat{{\mathbf{\text{f}}}}_{{d}}\odot\overline{\hat{{\mathbf{\text{h}}}}}_{{d}}}\right) \\
&= {\rm d}\left(\hat{{\mathbf{\text{f}}}}_{{d}}\odot\overline{\hat{{\mathbf{\text{h}}}}}_{{d}}\right) \\
&= \left({\rm d}\hat{{\bf f}}_d\right)\odot\overline{\hat{{\bf h}}}_d + \hat{{\bf f}}_d \odot {\rm d}\overline{\hat{{\bf h}}}_d \\
&= \hat{{\bf f}}_d \odot {\rm d}\overline{\hat{{\bf h}}}_d
\end{aligned}
\end{equation}
$$

因此
$$
\begin{equation}
\begin{aligned}
{\rm tr}\left(\overline{\bf c}^\top{\rm d}{\bf c}\right) &= {\rm tr}\left(\overline{\bf c}^\top\left(\hat{{\bf f}}_d \odot {\rm d}\overline{\hat{{\bf h}}}_d\right)\right) \\
&= {\rm tr}\left(\left(\overline{\bf c} \odot \hat{{\bf f}}_d\right)^\top {\rm d}\overline{\hat{{\bf h}}}_d\right)
\end{aligned}
\end{equation}
$$
故
$$
\boxed{
\begin{equation}
\begin{aligned}
\left[\frac{\partial\epsilon}{\partial\overline{\hat{{\bf h}}}_d}\right]_1 &= \overline{\bf c}\odot\hat{\bf f}_d \\
&= \left(\sum_{d=1}^{N_c}\overline{\hat{\bf f}}_d \odot \hat{\bf h}_d - \overline{\hat{\bf g}} \right) \odot \hat{\bf f}_d \\
&= \displaystyle{\sum_{{{d}={1}}}^{{{N}_{{c}}}}}\hat{{\mathbf{\text{f}}}}_{{d}}\odot\overline{\hat{{\mathbf{\text{f}}}}}_{{d}}\odot\hat{{\mathbf{\text{h}}}}_{{d}}-\overline{\hat{{\mathbf{\text{g}}}}}\odot\hat{{\mathbf{\text{f}}}}_{{d}} \\
&= \displaystyle\hat{{\mathbf{\text{h}}}}_{{d}}\odot{\sum_{{{d}={1}}}^{{{N}_{{c}}}}}{\mathtt{\textrm{diag}}}{\left(\hat{{\mathbf{\text{f}}}}_{{d}}\right)}\overline{\hat{{\mathbf{\text{f}}}}}_{{d}}-{\mathtt{\textrm{diag}}}{\left(\hat{{\mathbf{\text{f}}}}_{{d}}\right)}\overline{\hat{{\mathbf{\text{g}}}}}
\end{aligned}
\end{equation}
}
$$
又
$$
\begin{equation}
\begin{aligned}
{\rm d}\left(\displaystyle\lambda{\sum_{{{d}={1}}}^{{{N}_{{c}}}}}{\left\|{{\mathbf{\text{h}}}_{{d}}}\right\|}^{2}_{2}\right) &= {\rm d}\left(\lambda\left\|\hat{{\bf h}}_d\right\|_2^2\right) \\
&= {\rm d}\left(\lambda\hat{{\bf h}}_d^{\rm H}\hat{{\bf h}}_d\right) \\
&= \lambda\left(\left({\rm d}\hat{{\bf h}}_d\right)^{\rm H}\hat{{\bf h}}_d + \hat{{\bf h}}_d^{\rm H}{\rm d}\hat{{\bf h}}_d\right) \\
&= \lambda\left(\left({\rm d}\hat{{\bf h}}_d\right)^{\rm H}\hat{{\bf h}}_d\right) \\
&= {\rm tr}\left(\left(\lambda\hat{{\bf h}}_d\right)^\top{\rm d}\overline{\hat{{\bf h}}}_d\right)
\end{aligned}
\end{equation}
$$
因此
$$
\boxed{\left[\frac{\partial\epsilon}{\partial\overline{\hat{{\bf h}}}_d}\right]_2 = \lambda\hat{{\bf h}}_d}
$$
故
$$
\boxed {
\begin{equation}
\begin{aligned}
\frac{\partial\epsilon}{\partial\overline{\hat{{\bf h}}}_d} &= \left[\frac{\partial\epsilon}{\partial\overline{\hat{{\bf h}}}_d}\right]_1 + \left[\frac{\partial\epsilon}{\partial\overline{\hat{{\bf h}}}_d}\right]_2 \\
&= \displaystyle\hat{{\mathbf{\text{h}}}}_{{d}}\odot{\sum_{{{d}={1}}}^{{{N}_{{c}}}}}{\mathtt{\textrm{diag}}}{\left(\hat{{\mathbf{\text{f}}}}_{{d}}\right)}\overline{\hat{{\mathbf{\text{f}}}}}_{{d}}-{\mathtt{\textrm{diag}}}{\left(\hat{{\mathbf{\text{f}}}}_{{d}}\right)}\overline{\hat{{\mathbf{\text{g}}}}} + \lambda\hat{{\bf h}}_d
\end{aligned}
\end{equation}
}
$$
令 $\dfrac{\partial\epsilon}{\partial\overline{\hat{{\bf h}}}_d} = 0$，解得
$$
\boxed{
\displaystyle\hat{{\mathbf{\text{h}}}}_{{d}} = \left({\mathtt{\textrm{diag}}}{\left(\hat{{\mathbf{\text{f}}}}_{{d}}\right)}\overline{\hat{{\mathbf{\text{g}}}}}\right) \displaystyle\odot^{ -{{1}}} \left({\sum_{{{d}={1}}}^{{{N}_{{c}}}}}{\mathtt{\textrm{diag}}}{\left(\hat{{\mathbf{\text{f}}}}_{{d}}\right)}\overline{\hat{{\mathbf{\text{f}}}}}_{{d}} + \lambda\right)
}
$$
