---
title: "Branch and Bound (B&amp;B)"
date: 2026-02-27
print_tag: "bab"
layout: "tag"
permalink: "/tags/bab"
tags: ["optimization"]
use_math: true
---

Branch and Bound&nbsp;(B&amp;B) algorithms are exact anytime {% include taglink.liquid tag="optimization" %} algorithms.
They iteratively divide the search space&nbsp;${\mathbb{X}}% into smaller and smaller subsets&nbsp;$X\subseteq\mathbb{X}$.
For each subset&nbsp;$X$, they maintain a lower bound&nbsp;$L(X)$ for the objective values of any element&nbsp;$x\in X$.
They also maintain an upper bound&nbsp;$U$ of the objective value of the best possible solution.
Initially,&nbsp;$U=\infty$.
If a subset contains only a single solution&nbsp;$x_s$, then we compute the objective value&nbsp;$f(x_s)$ of&nbsp;$x_s$ and update&nbsp;$U\gets\min\{U,f(x_s)\}$.
Of course, from now on, we only need to consider subsets&nbsp;$X$ with&nbsp;$L(X)<U$, because otherwise, they cannot contain any solution better than&nbsp;$x_s$.
