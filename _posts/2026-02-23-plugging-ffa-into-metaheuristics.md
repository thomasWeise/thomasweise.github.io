---
title: "Plugging Frequency Fitness Assignment into Metaheuristics"
date: 2026-02-23
last_modified_at: 2026-02-23
use_math: true
tags: ["FFA", "local_search", "metaheuristics", "RLS", "(1+1) EA", "FRLS", "(1+1) FEA"]
algorithms: ["metaheuristic"]
---

## Metaheuristic Optimization
Frequency Fitness Assignment&nbsp;({%- include taglink.liquid tag="FFA" -%}) is a technique that redefines how we do metaheuristic optimization.
Metaheuristic algorithms, like Evolutionary Algorithms&nbsp;(EAs), local search, Simulated Annealing&nbsp;(SA), or Tabu Search&nbsp;(TS) proceed iteratively according to the cycle given in {% include algorithm_link.liquid id="metaheuristic" -%}.
At each iteration&nbsp;$i$, they maintain a set&nbsp;$S_i$ of interesting candidate solutions&nbsp;$x\in S_i$ from the solution space&nbsp;$\mathbb{X}$.
They use these selected solutions in one way or another to sample a set&nbsp;$N_i$ of new solutions.
This may happen via a unary search operator&nbsp;(called "mutation" in EA-lingo) or a binary operator&nbsp;(often called "crossover" or "recombination") or in any other imaginable way.
Either way, we get a set of new solutions&nbsp;$N_i$.
Then, $S_i$ and $N_i$ are combined into a set&nbsp;$P_i=S_i\cup N_i$ and the set&nbsp;$S_{i+1}\subseteq P_i$ for the next iteration is chosen from it.
Now, normally, the better a solution&nbsp;$x\in P_i$ relative to the other members of&nbs;$P_i$, the higher its chance to be selected into&nbsp;$S_{i+1}$.

{::nomarkdown}{%- capture myalgo -%}
Sample set&nbsp;$S_1$ of initial solutions from the solution space&nbsp;$\mathbb{X}$.
@[For@] $i$ @[from@] 1 @[to@]$\dots$
@1: Create set&nbsp;$N_i$ of new solutions based on&nbsp;$S_i$.
@1: $P_i\gets S_i\cup N_i$.
@1: Select set $S_{i+1}$ from $P_i$ according to some policy.
{%- endcapture -%}
{%- include algorithm.liquid text=myalgo id="metaheuristic" caption="The normal cycle of metaheuristic algorithms." -%}{:/}

And this makes a lot of sense.
This is how trial-and-error works:
We try different solutions for problem and look how good they work.
Then we continue with slightly modified versions the solution that we liked best in order to find even better.
This iterative procedure of trial and error with a bias for better solutions is foundation of metaheuristic optimization.
