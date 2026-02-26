---
title: "Plugging Frequency Fitness Assignment into Metaheuristics"
date: 2026-02-23
last_modified_at: 2026-02-25
use_math: true
tags: ["FFA", "local_search", "metaheuristics", "RLS", "FRLS", "optimization"]
algorithms: ["metaheuristic", "RLS", "FRLS"]
---

Frequency Fitness Assignment&nbsp;({%- include taglink.liquid tag="FFA" -%}) is a technique that fundamentally changes how (metaheuristic) optimization algorithms work.
The goal of this post is to explore how this technique can be plugged into an existing algorithm.
We first discuss optimization and the general pattern of metaheuristics in general.
We then discuss the simplest local search algorithm -- randomized local search, or {% include taglink.liquid tag="RLS" %} for short.
We plug FFA into this algorithm and obtain the {% include taglink.liquid tag="FRLS" -%}.
We finally list some properties of FRLS as well as some related works.

## Optimization
If we try to solve an optimization problem, then we have at least the following components available: 

- a data structure called the solution space&nbsp;$\mathbb{X}$, which contains the possible candidate solutions&nbsp;$x\in\mathbb{X}$,
- the objective function&nbsp;$f:\mathbb{X}\mapsto\mathbb{R}$, which rates the candidate solutions and which we here consider to be subject to minimization, i.e., smaller values are better, i.e., $f(x_1)<f(x_2)$ means that&nbsp;$x_1$ is better than&nbsp;$x_2$, and
- some way to instantiate the data structure&nbsp;$\mathbb{X}$, usually either fully randomly or by copying and slightly (randomly) an existing instance&nbsp;$x$. 

We then try to find the values&nbsp;$x^{\star}$ for which the objective function&nbsp;$f$ takes on the smallest possible value.
Of course, finding such points is very hard and may not be possible within reasonable time if&nbsp;$\mathbb{X}$ is big.
Therefore, at least we try to find some&nbsp;$x$ for which&nbsp;$f(x)$ gets as small as possible.

## Metaheuristic Optimization
Metaheuristic algorithms, like Evolutionary Algorithms&nbsp;({%- include taglink.liquid tag="EAs" -%}), {% include taglink.liquid tag="local_search" -%}, Simulated Annealing&nbsp;({%- include taglink.liquid tag="SA" -%}), or {% include taglink.liquid tag="tabu_search" -%} do this by proceeding iteratively according to the cycle given in {% include algorithm_link.liquid id="metaheuristic" -%}.
At each iteration&nbsp;$i$, they maintain a set&nbsp;$S_i$ of interesting candidate solutions&nbsp;$x\in S_i$ from the solution space&nbsp;$\mathbb{X}$.
They use these selected solutions in one way or another to sample a set&nbsp;$N_i$ of new solutions.
This may happen via a unary search operator&nbsp;(called "mutation" in EA-lingo) or a binary operator&nbsp;(often called "crossover" or "recombination") or in any other imaginable way.
Either way, we get a set of new solutions&nbsp;$N_i$.
Then, $S_i$ and $N_i$ are combined into a set&nbsp;$P_i=S_i\cup N_i$ and the set&nbsp;$S_{i+1}\subseteq P_i$ for the next iteration is chosen from it.
Now, normally, the better a solution&nbsp;$x\in P_i$ relative to the other members of&nbsp;$P_i$, meaning the smaller its corresponding objective value&nbsp;$f(x)$, the higher its chance to be selected into&nbsp;$S_{i+1}$.

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

Frequency Fitness Assignment&nbsp;({%- include taglink.liquid tag="FFA" -%}) is a technique that breaks with this bias.
It thus redefines how we do metaheuristic optimization.
FFA is a modification that can be introduced into existing algorithms.
In order to see how that works, we first look at one concrete metaheuristic method and then plug FFA into it.

## Randomized Local Search (RLS)
Let us thus consider the simplest metaheuristic, namely *Randomized Local Search*&nbsp;({%- include taglink.liquid tag="RLS" -%}).
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
This means that, if&nbsp;$y_n\leq y_c$, $x_c\gets x_n$ and $y_c\gets y_n$.
After the complete computational budget is exhausted, the algorithm returns the best solution that it has discovered&nbsp;(namely&nbsp;$x_c$) as well as its quality&nbsp;$y_c$.
This process is illustrated as {% include algorithm_link.liquid id="RLS" -%}.

{::nomarkdown}{%- capture myalgo -%}
Sample solution&nbsp;$x_c$ uniformly at random from&nbsp;$\mathbb{X}$.
$y_c\gets f(x_c)$.
@[Until@] $\lnot$&nbsp;should terminate @[repeat@]
@1: $x_n\gets\mathit{Op1}(x_c)$; $y_n\gets f(x_n)$.
@1: @[If@] $y_n \leq y_c$ @[then@]
@2: $x_c\gets x_n$; $y_c\gets y_n$.
@[Return@] $x_c, y_c$.
{%- endcapture -%}
{%- include algorithm.liquid text=myalgo id="RLS" caption="The randomized local search&nbsp;(RLS)." -%}{:/}

## Randomized Local Search with FFA (FRLS)
Now let's plug FFA into the RLS algorithm and we obtain the {% include taglink.liquid tag="FRLS" -%}.
We first provide FRLS as {% include algorithm_link.liquid id="FRLS" %} and then discuss it step-by-step.
It should be noted upfront that this algorithm will *only* work if the objective function is discrete, i.e., takes on a finite (and ideally small) number of different values.

{::nomarkdown}{%- capture myalgo -%}
<span style="color:DarkViolet">$H\gets (0, 0, \dots, 0)$.</span>
Sample solution&nbsp;$x_c$ uniformly at random from&nbsp;$\mathbb{X}$.
$y_c\gets f(x_c)$.
<span style="color:blue">$x_b\gets x_c$; $y_b\gets y_c$.</span>
@[Until@] $\lnot$&nbsp;should terminate @[repeat@]
@1: $x_n\gets\mathit{Op1}(x_c)$; $y_n\gets f(x_n)$.
@1: <span style="color:DarkViolet">$H[y_c]\gets H[y_c]+1$; $H[y_n]\gets H[y_n]+1$.</span>
@1: <span style="color:DarkViolet">@[If@] $H[y_n] \leq H[y_c]$ @[then@]</span>
@2: $x_c\gets x_n$; $y_c\gets y_n$.
@2: <span style="color:blue">@[If@] $y_n &lt; y_b$ @[then@]</span>
@3: <span style="color:blue">$x_b\gets x_n$; $y_b\gets y_n$.</span>
@[Return@] <span style="color:blue">$x_b, y_b$.</span>
{%- endcapture -%}
{%- include algorithm.liquid text=myalgo id="FRLS" caption="The randomized local search with FFA, i.e., the FRLS algorithm." -%}{:/}

Let us first discuss the core changes when transitioning to FFA, which are marked with <span style="color:DarkViolet">violet</span> color.
The algorithm now uses a frequency table&nbsp;$H$.
$H$&nbsp;counts how often each objective value was encountered during the selection step.
It could be implemented a simple array or a hash map.
We denote the initialization of this data structure by symbolically writing $H\gets (0, 0, \dots, 0)$.

The creation and evaluation of the initial solution&nbsp;$x_c$ and the new solution&nbsp;$x_n$ sampled in each iteration stay exactly the same.
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
From a simplified perspective, this means that we accept the new solution if its objective value appares to be more rare than the objective value of the current solution.

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

Anyway, neither&nbsp;$x_b$ nor&nbsp;$y_b$ influence the search in any way.
They are strictly used to remember the best-so-far solutions, but have no impact on where the search will take us next.
That is entirely decided by the frequency table&nbsp;$H$.

## Basic References
### Bit-String based Search Spaces
First, let us consider the problem type where all solutions&nbsp;$x$ are bit strings of length&nbsp;$n$. 

{::nomarkdown}{%- assign papers="WWLCL2023FFAOWBFGSCBE,WWLC2021FFAMOAIUBTOTOFV" | split: "," -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}

In the two papers above, we introduce FFA into the (1+1)&nbsp;EA.
The RLS and the (1+1)&nbsp;EA are basically the same algorithm but differ in their unary search operator&nbsp;$\mathit{Op1}$.
Usually, when we talk about the (1+1)&nbsp;EA, the search or solution space&nbsp;$\mathbb{X}$ corresponds to bit strings of length&nbsp;$n$, i.e., $\{`0`,`1`\}^n$.
Here, each decision variable is either `0`&nbsp;(meaning&nbsp;`False`) or `1`&nbsp;(meaning&nbsp;`True`).
When we consider this domain, the terms "RLS" and "(1+1)&nbsp;EA" have the following meaning:

- In the RLS, the unary operator&nbsp;$\mathit{Op1}(x_c)$ creates a copy of&nbsp;$x_c$, then randomly chooses one bit and flips it.
- In the (1+1)&nbsp;EA, the unary operator&nbsp;$\mathit{Op1}(x_c)$ creates a copy of&nbsp;$x_c$ and then, for each of the $n$&nbsp;bits, decides randomly whether it should be flipped.
  Usually, the per-bit flipping probability is&nbsp;$1/n$.
  Usually, it is ensured that at least one bit is flipped.

Otherwise, both algorithms have exactly the same procedure as detailed in {% include algorithm_link.liquid id="RLS" -%}.
Either way, we plugged FFA into this (1+1)&nbsp;EA and obtained the (1+1)&nbsp;FEA, which is basically equivalent to the {% include algorithm_link.liquid id="FRLS" -%}.
And then we did lots of experiments with it.
And found that it actually works quite well.
And more you can read in the papers.

### Other Domains
If the search domain is not bit strings, then we can use the terms RLS and (1+1)&nbsp;EA more or less synonymously.
Sometimes, one may use "RLS" to indicate that the search operator&nbsp;$\mathit{Op1}(x_c)$ has a fixed neighborhood from which solutions are sampled uniformly.
Then, "(1+1)&nbsp;EA" may be used for situations where basically every possible solution can be reached within a single step, albeit at different probabilities.

Some examples, i.e., a subset of our work on FFA, can be found here:

- Permutations:
  The Search Space&nbsp;$\mathbb{X}$ corresponds to permutations of the first&nbsp;$n$ natural numbers.
  + Traveling Salesperson Problem&nbsp;({% include taglink.liquid tag="TSP" %})
    {::nomarkdown}{%- assign papers="LWLvdBTW2024ATTSPWFFAAHA,LWTWW2024GSIWIFFTTSP,LWLvdbW2022STTSPUFFA" | split: "," -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}
  + Quadratic Assignment Problem&nbsp;({% include taglink.liquid tag="QAP" %})
    {::nomarkdown}{%- assign papers="CWTW2024FFAOWBFGSORLSOTQAP,TOvdBLW2024ESTAEFFFA" | split: "," -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}
  + Traveling Tournament Problem&nbsp;({% include taglink.liquid tag="TTP" %})
    {::nomarkdown}{%- assign papers="XWvdBW2024RLSVNVFFAOTTTP" | split: "," -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}
- Permutations with Repetitions:
  Each one of the first&nbsp;$n$ natural numbers occurs exactly a per-number specific amount of times in the permutations.
  + Job Shop Scheduling Problem({% include taglink.liquid tag="JSSP" %})
    {::nomarkdown}{%- assign papers="WLCW2021SJSSPWUABFGS,WWLC2021FFAMOAIUBTOTOFV" | split: "," -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}
  + Two-Dimensional Bin&nbsp;({% include taglink.liquid tag="packing" tag_text="Packing" %})
    {::nomarkdown}{%- assign papers="ZWvdBTLTW2024RLSFTDBPAANRFFA,ZLWvdBTW2024RLSOT2RBPPWIR" | split: "," -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}
    

## Features of FRLS
The {% include taglink.liquid tag="FRLS" %} has several interesting features.

1. Its search is unbiased.
   The probability of being selected of a solution depends on how often its objective value has entered the selection stage before.
   It does not depend on whether the objective value is good or bad.
2. The path that the algorithm takes through the search space remains the same if we replace&nbsp;$f(x)$ with any&nbsp;$g(f(x))$ as long as $g$&nbsp;is an injective function.
   The objective values are only used as indices into the frequency table&nbsp;$H$.
   It does not matter whether they are high or low, only their identity matters.
3. Since the FRLS algorithm does not care whether a solution is good or bad, it tends to optimize into the "wrong direction" half of the time and oscillate between searching good and bad solutions.
4. This makes the search much slower, but it also adds a very strong explorative character.
5. If there are many different possible objective values, the search will degenerate to a random walk.
   FRLS can only work if there is only a relatively small set of possible objective values.

## More
[Here](/research/areas/ffa) you can learn more about FFA and the latest research that we do on this odd topic. 
We also provide implementations of the (1+1)&nbsp;EA/RLS as well as of the (1+1)&nbsp;FEA/FRLS in our Python framework {% include taglink.liquid tag="moptipy" -%}.
