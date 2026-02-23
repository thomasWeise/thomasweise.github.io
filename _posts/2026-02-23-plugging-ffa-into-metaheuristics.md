---
title: "Plugging Frequency Fitness Assignment into Metaheuristics"
date: 2026-02-23
last_modified_at: 2026-02-23
use_math: true
tags: ["FFA", "local_search", "metaheuristics", "RLS", "(1+1) EA", "FRLS", "(1+1) FEA"]
algorithms: ["metaheuristic", "RLS", "FRLS"]
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

## Randomized Local Search (RLS)
Let us consider the simplest metaheuristic, namely *Randomized Local Search*&nbsp;(RLS).
RLS&nbsp;begins by sampling one candidate solution&nbsp;$x_c$ from the solution space&nbsp;$\mathbb{X}$ uniformly at random.
It computes the objective value&nbsp;$y_c$ of&nbsp;$x_c$ by evaluating the objective function&nbsp;$f:\mathbb{X}\mapsto\mathbb{R}$.
Let's assume that&nbsp;$f$ is subject to minimization, i.e., represents some sort of cost or amount of consumed resource.
$y_c\gets f(x_c)$&nbsp;then is the quality of the current solution&nbsp;$x_c$ and&nbsp;$x_c$ is the better, the smaller&nbsp;$y_c$ is.
In the scheme given in {% include algorithm_link.liquid id="metaheuristic" -%}, we would basically have&nbsp;$S_i=\{x_c\}$.

Now, in its main loop, RLS creates a slightly modified copy&nbsp;$x_n$ of the&nbsp;$x_c$.
It does so by applying a unary operator&nbsp;$\mathit{op1}$ to&nbsp;$x_c$.
$\mathit{op1}$&nbsp;is usually randomized, meaning that it copies&nbsp;$x_c$ and then randomly changes one or multiple components of that copy.
Either way, we get a new solution&nbsp;$x_n\gets\mathit{op1}(x_n)$.
This solution is then also evaluated and we obtain its objective value&nbsp;$y_n\gets f(x_n)$.
In the scheme given in {% include algorithm_link.liquid id="metaheuristic" -%}, we would basically have&nbsp;$N_i=\{x_n\}$.

In its selection step, RLS retains&nbsp;$x_n$ if it is not worse than&nbsp;$x_c$.
This means that, if&nbsp;$y_n\leq y_c$, $x_c\gets\x_n$ and $y_c\gets y_n$.
After the complete computational budget is exhausted, the algorithm returns the best solution that it has discovered&nbsp;(namely&nbsp;$x_c$) as well as its quality&nbsp;$y_c$.
This process is illustrated as {% include algorithm_link.liquid id="RLS" -%}.

{::nomarkdown}{%- capture myalgo -%}
Sample solution&nbsp;$x_c$ uniformly at random from&nbsp;$\mathbb{X}$.
$y_c\gets f(x_c)$.
@[Until@] computational budget exhausted @[repeat@]
@1: $x_n\gets\mathit{Op1}(x_c)$; $y_n\gets f(x_n)$.
@1: @[If@] $y_n \leq y_c$ @[then@]
@2: $x_c\gets x_n$; $y_c\gets y_n$.
@[Return@] $x_c, y_c$.
{%- endcapture -%}
{%- include algorithm.liquid text=myalgo id="RLS" caption="The randomized local search&nbsp;(RLS)." -%}{:/}

## Randomized Local Search with FFA (FRLS)
Now let's plug FFA into the RLS algorithm and we obtain the FRLS.
We first provide FRLS as {% include algorithm_link.liquid id="FRLS" -%} and then discuss it step-by-step.
It should be noted upfront that this algorithm will *only* work if the objective function is discrete, i.e., takes on a finite (and ideally small) number of different values.

{::nomarkdown}{%- capture myalgo -%}
<span style="color:DarkViolet">$H\gets (0, 0, \dots, 0)$.</span>
Sample solution&nbsp;$x_c$ uniformly at random from&nbsp;$\mathbb{X}$.
$y_c\gets f(x_c)$.
<span style="color:blue">$x_b\gets x_c$; $y_b\gets y_c$.</span>
@[Until@] computational budget exhausted @[repeat@]
@1: $x_n\gets\mathit{Op1}(x_c)$; $y_n\gets f(x_n)$.
@1: <span style="color:DarkViolet">$H[y_c]\gets H[y_c]+1$; $H[y_n]\gets H[y_n]+1$.</span>
@1: <span style="color:DarkViolet">@[If@] $H[y_n] \leq H[y_c]$ @[then@]</span>
@2: $x_c\gets x_n$; $y_c\gets y_n$.
@2: <span style="color:blue">@[If@] $y_n &lt; y_b$ @[then@]</span>
@3: <span style="color:blue">$x_b\gets x_n$; $y_b\gets y_n$.</span>
@[Return@] <span style="color:blue">$x_b, y_b$.</span>
{%- endcapture -%}
{%- include algorithm.liquid text=myalgo id="FRLS" caption="The randomized local search with FFA, i.e., the FRLS algorithm." -%}{:/}
