---
title: "Randomized Local Search with Frequency Fitness Assignment (FRLS)"
date: 2026-02-27
print_tag: "FRLS"
layout: "tag"
permalink: "/tags/frls"
tags: ["metaheuristics", "local_search", "RLS", "FFA"]
use_math: true
algorithms: ["FRLS"]
---

Randomized local search&nbsp;({% include taglink.liquid tag="rls" %}) is maybe the simplest {% include taglink.liquid tag="local_search" %} algorithm.
It maintains one single best-so-far solution and in each step, it samples one new solution by applying the unary search operator to it.
It will accept the new solution as the current solution if it is not worse.
If we plug Frequency Fitness Assignment&nbsp;({% include taglink.liquid tag="ffa" %}) into this algorithm, we obtain the FRLS.

## The Algorithm

We first provide FRLS as {% include algorithm_link.liquid id="FRLS" %} and then discuss it step-by-step.
It should be noted upfront that this algorithm will *only* work if the objective function is discrete, i.e., takes on a finite (and ideally small) number of different values.

{::nomarkdown}{%- capture myalgo -%}
$H\gets (0, 0, \dots, 0)$.
Sample solution&nbsp;$x_c$ uniformly at random from&nbsp;$\mathbb{X}$.
$y_c\gets f(x_c)$.
<span style="color:blue">$x_b\gets x_c$; $y_b\gets y_c$.</span>
@[Until@] $\lnot$&nbsp;should terminate @[repeat@]
@1: $x_n\gets\mathit{op1}(x_c)$; $y_n\gets f(x_n)$.
@1: $H[y_c]\gets H[y_c]+1$; $H[y_n]\gets H[y_n]+1$.
@1: @[If@] $H[y_n] \leq H[y_c]$ @[then@]
@2: $x_c\gets x_n$; $y_c\gets y_n$.
@2: <span style="color:blue">@[If@] $y_n &lt; y_b$ @[then@]</span>
@3: <span style="color:blue">$x_b\gets x_n$; $y_b\gets y_n$.</span>
@[Return@] <span style="color:blue">$x_b, y_b$.</span>
{%- endcapture -%}
{%- include algorithm.liquid text=myalgo id="FRLS" caption="The randomized local search with FFA, i.e., the FRLS algorithm." -%}{:/}

Let us first discuss the most important changes compared to a normal {% include taglink.liquid tag="local_search" %} like {% include taglink.liquid tag="RLS" %}.
FRLS uses a frequency table&nbsp;$H$ to determine how interesting solutions are.
$H$&nbsp;counts how often each objective value was encountered during the selection step.
It could be implemented a simple array or a hash map.
We denote the initialization of this data structure by symbolically writing $H\gets (0, 0, \dots, 0)$.

The creation and evaluation of the initial solution&nbsp;$x_c$ and the new solution&nbsp;$x_n$ sampled in each iteration stay the same as in any other local search.
When the algorithm starts, the first value of&nbsp;$x_c$ is sampled uniformly at random from the solution space&nbsp;$\mathbb{X}$.
Its objective value&nbsp;$y_c$ is computed by evaluating the objective function&nbsp;$f$ as&nbsp;$y_c\gets f(x_c)$.
In each iteration of the main loop, a new candidate solution&nbsp;$x_n$ is sampled by applying the unary search operator&nbsp;$\mathit{op1}$ to&nbsp;$x_c$.
The new solution is evaluated and its objective value is stored in&nbsp;$y_n$.
This is exactly the same compared to what RLS does.

However, before the selection step, i.e., before we decide which of the two we want to keep, a new line appears:
$H[y_c]\gets H[y_c]+1$&nbsp;and $H[y_n]\gets H[y_n]+1$ increment the frequency counters of the objective values&nbsp;$y_c$ and&nbsp;$y_n$ of&nbsp;$x_c$ and&nbsp;$x_n$, respectively.
In other words, $H[y_c]$&nbsp;now represents how often a solution with objective value&nbsp;$y_c$ took place in the selection.
And, of course, $H[y_n]$&nbsp;now represents how often a solution with objective value&nbsp;$y_n$ took place in the selection.

The selection decision is also changed:
Instead of comparing&nbsp;$y_n\leq y_c$, we now compare&nbsp;$H[y_n] \leq H[y_c]$.
If this comparison yields true, then&nbsp;$x_n$ replaces&nbsp;$x_c$ and&nbsp;$y_c$ is overwritten with&nbsp;$y_n$.
What does this mean?
In RLS, we select the new solution&nbsp;$x_n$ if it is either better than the current solution&nbsp;$x_c$ or equally good.
In FRLS, we select the new solution&nbsp;$x_n$ if its objective value&nbsp;$y_n$ was encountered more rarely or equally often in the selection decisions compared to the objective value&nbsp;$y_c$ of the current solution&nbsp;$x_c$.
From a simplified perspective, this means that we accept the new solution if its objective value appears to be more rare than the objective value of the current solution.

This means that, in FRLS, it does not really matter whether the new solution is better than the current solution.
Indeed, the algorithm may well accept worse solutions and in experiments "optimizes" into the "wrong" direction about half of the time.
This waste of time facilitates its exploration capability, though.

It also means that the best solution that this algorithm discovers is likely to get lost and overwritten.
This can never happen in RLS.
But in FRLS, it can.
And thus, we need the <span style="color:blue">blue</span> part.
We remember the best-ever encountered solution in an additional variable&nbsp;$x_b$ and its objective value in a variable&nbsp;$y_b$.
These two values are returned when the algorithm has finished, e.g., exhausted its computational budget.
They are initialized right at the beginning of the algorithm.
We check whether they should be updated when&nbsp;$H[y_n] \leq H[y_c]$, because only if&nbsp;$y_n$ was encountered less often than&nbsp;$y_c$, it can represent a new best-so-far solution.
Otherwise, it has been encountered already at least once before, so it might have corresponded to a new best-so-far solution back then, but not now.

Neither&nbsp;$x_b$ nor&nbsp;$y_b$ influence the search in any way.
They are strictly used to remember the best-so-far solutions, but have no impact on where the search will take us next.
That is entirely decided by the frequency table&nbsp;$H$.
FRLS thus is no longer searching for better solutions, but for solutions whose objective value was encountered less often so far.
