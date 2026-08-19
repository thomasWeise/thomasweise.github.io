---
title: "Randomized Local Search (RLS)"
date: 2026-02-27
print_tag: "RLS"
layout: "tag"
permalink: "/tags/rls"
tags: ["metaheuristics", "local_search", "FRLS"]
algorithms: ["RLS"]
use_math: true
---

Randomized local search&nbsp;(RLS) is maybe the simplest {% include taglink.liquid tag="local_search" %} algorithm.
It maintains one single best-so-far solution&nbsp;$x_c$ and in each step, it samples one new solution&nbsp;$x_n$ by applying the unary search operator to it.
It will accept the new solution&nbsp;$x_n$ as the current solution&nbsp;$x_c$ if it is not worse.
This search works already surprisingly well on a wide set of optimization problems.
It can be viewed as the bottom line that any new {% include taglink.liquid tag="metaheuristics" tag_text="metaheuristic" %} must significantly outperform to be worth its salt.

## The Algorithm

{::nomarkdown}{%- capture myalgo -%}
Sample solution&nbsp;$x_c$ uniformly at random from&nbsp;$\mathbb{X}$.
$y_c\gets f(x_c)$.
@[Until@] $\lnot$&nbsp;should terminate @[repeat@]
@1: $x_n\gets\mathit{op1}(x_c)$; $y_n\gets f(x_n)$.
@1: @[If@] $y_n \leq y_c$ @[then@]
@2: $x_c\gets x_n$; $y_c\gets y_n$.
@[Return@] $x_c, y_c$.
{%- endcapture -%}
{%- include algorithm.liquid text=myalgo id="RLS" caption="The randomized local search&nbsp;(RLS)." -%}{:/}

RLS&nbsp;begins by sampling one candidate solution&nbsp;$x_c$ from the solution space&nbsp;$\mathbb{X}$ uniformly at random.
It computes the objective value&nbsp;$y_c$ of&nbsp;$x_c$ by evaluating the objective function&nbsp;$f:\mathbb{X}\mapsto\mathbb{R}$.
Let's assume that&nbsp;$f$ is subject to minimization, i.e., represents some sort of cost or amount of consumed resource.
$y_c\gets f(x_c)$&nbsp;then is the quality of the current solution&nbsp;$x_c$ and&nbsp;$x_c$ is the better, the smaller&nbsp;$y_c$ is

Now, in its main loop, RLS creates a slightly modified copy&nbsp;$x_n$ of the&nbsp;$x_c$.
It does so by applying a unary operator&nbsp;$\mathit{op1}$ to&nbsp;$x_c$.
$\mathit{op1}$&nbsp;is usually randomized, meaning that it first copies&nbsp;$x_c$ and then randomly changes one or multiple components of that copy.
Either way, we get a new solution&nbsp;$x_n\gets\mathit{op1}(x_n)$.
This solution is then also evaluated and we obtain its objective value&nbsp;$y_n\gets f(x_n)$.

In its selection step, RLS retains&nbsp;$x_n$ if it is not worse than&nbsp;$x_c$.
This means that, if&nbsp;$y_n\leq y_c$, $x_c\gets x_n$ and $y_c\gets y_n$.
After the complete computational budget is exhausted, the algorithm returns the best solution that it has discovered&nbsp;(namely&nbsp;$x_c$) as well as its quality&nbsp;$y_c$.
This process is illustrated as {% include algorithm_link.liquid id="RLS" -%}.

If we plug Frequency Fitness Assignment&nbsp;({% include taglink.liquid tag="ffa" %}) into this algorithm, we obtain the {% include taglink.liquid tag="frls" %}.
But this is a story for another [page]({%- post_url 2026-02-23-plugging-ffa-into-metaheuristics -%}).
