---
title: "Metaheuristics"
date: 2026-04-03
print_tag: "metaheuristics"
layout: "tag"
permalink: "/tags/metaheuristics"
tags: ["metaheuristics", "optimization"]
use_math: true
algorithms: ["metaheuristic"]
---

Metaheuristics are general {% include taglink.liquid tag="optimization" %} procedures that can be applied to a wide variety of problems.
They are not problem-specific and often have a rather simple structure, a loop of sampling and selection as given in {% include algorithm_link.liquid id="metaheuristic" -%}.
At each iteration&nbsp;$i$, they maintain a set&nbsp;$S_i$ of interesting candidate solutions&nbsp;$x\in S_i$ from the solution space&nbsp;$\mathbb{X}$.
They use these selected solutions in one way or another to sample a set&nbsp;$N_i$ of new solutions.
This may happen via a unary search operator, a binary operator, by updating some statistical model and then sampling the model, or by using any other imaginable method.
Either way, we get a set of new solutions&nbsp;$N_i$.
Then, $S_i$ and $N_i$ are combined into a set&nbsp;$P_i=S_i\cup N_i$ and the set&nbsp;$S_{i+1}\subseteq P_i$ for the next iteration is chosen from it.
Normally, the better a solution&nbsp;$x\in P_i$ relative to the other members of&nbsp;$P_i$, meaning the smaller its corresponding objective value&nbsp;$f(x)$, the higher its chance to be selected into&nbsp;$S_{i+1}$.
This is how trial-and-error works:

{::nomarkdown}{%- capture myalgo -%}
Sample set&nbsp;$S_1$ of initial solutions from the solution space&nbsp;$\mathbb{X}$.
@[For@] $i$ @[from@] 1 @[to@]$\dots$
@1: Create set&nbsp;$N_i$ of new solutions based on&nbsp;$S_i$.
@1: $P_i\gets S_i\cup N_i$.
@1: Select set $S_{i+1}$ from $P_i$ according to some policy.
{%- endcapture -%}
{%- include algorithm.liquid text=myalgo id="metaheuristic" caption="The normal cycle of metaheuristic algorithms." -%}{:/}

Many different algorithms follow this pattern.
The most common sub-fields are

- {% include taglink.liquid tag="local_search" %}&nbsp;(including, e.g., {% include taglink.liquid tag="RLS" %}, {% include taglink.liquid tag="SA" %}, and {% include taglink.liquid tag="tabu_search" %})
- {% include taglink.liquid tag="EC" tag_text="evolutionary computation" %} methods&nbsp;(such as&nbsp;{% include taglink.liquid tag="EAs" %}, {% include taglink.liquid tag="GAs" %}, and {% include taglink.liquid tag="MAs" %}) and
- {% include taglink.liquid tag="si" tag_text="swarm intelligence" %} methods&nbsp;(most prominently, {% include taglink.liquid tag="ACO" %} and {% include taglink.liquid tag="PSO" %}).
