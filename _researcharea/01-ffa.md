---
title: "Frequency Fitness Assignment"
permalink: /research/areas/ffa
read_time: false
toc: true
author_profile: true
date: 2026-02-05
last_modified_at: 2026-02-18
use_math: true
use_algorithm: true
---

Frequency Fitness Assignment&nbsp;(FFA, {% include lang.liquid text="频率适应度分配" nowrap=true -%}) is a novel approach to metaheuristic optimization.
Actually, it abandons the very core principles of metaheuristic optimization.
And yet, it works.

## Introduction
Many important problems in optimization and operations research are NP-hard, which means that algorithms that can guarantee to always find their optimal solution may take a runtime exponential in the problem size in the worst case.
In layman's terms, this simply means *"If an algorithm guarantees you to find the best possible solution for a given problem, it might take waaaaay to long on some instances of these problems."*
Metaheuristic optimization algorithms are methods that do not guarantee to find the optimal solutions.
However, they tend to be quite fast in giving us *good* solutions and sometimes even find the optimal solutions anyway.

They are based on the simple principle of *"trial and error."*
All of them have in common that they repeatedly sample candidate solutions in one way or another, pick the better ones of these candidates with higher probability, and use those as basis to sample new solutions similar to them.
Regardless if you have a local search, an Evolutionary Algorithm, Simulated Annealing, Tabu Search or even Estimation of Distribution algorithms &mdash; they all adopt this principle to prefer better solutions as basis for sampling new solutions.

Frequency Fitness Assignment&nbsp(FFA) abandons this bias toward better solutions.
Instead, it prefers solutions whose objective values (or costs, or quality rating, whatever you prefer) have been encountered less frequently in the selection decisions during the search.
In other words, it does no longer matter whether one solution is better.
Matter of fact, algorithms using FFA may "optimize" toward worse solutions half of their time.

## Invariance
Dropping the bias towards better solutions has an interesting consequence:
Algorithms that use FFA are invariant under all injective transformations of the objective function value.
This is the strongest theoretically possible invariance property.
The only other algorithms that have it are random sampling, random walks, and exhaustive enumeration.
These methods, however, are pretty awful approaches to optimization.
Not FFA, though, as it turned out to work quite well in domains such as {% include taglink.liquid tag="MaxSat" -%}, the {% include taglink.liquid tag="TSP" tag_text="Traveling Salesperson Problem" -%}, the {% include taglink.liquid tag="QAP" tag_text="Quadratic Assignment Problem" %}, and on discrete benchmark functions.

But what does this invariance property mean?
Imagine that you replace the objective function $f(x)$ with a function $g(x)=-f(x)$.
If you try to solve both functions with an FFA-based algorithm, the algorithm will take the exactly same path through the search space.
Matter of fact, you could replace $f(x)$ with a function that *encrypts* its output and only pass the *encrypted* objective values on to the algorithm.
It will still take the same path through the search space.
It would take you to the same optimal solution (from the perspective of $f(x)$) at exactly the same time step as if it was working on $f(x)$ directly.
How weird is that?

## Features of FFA

- **Advantages:**
  - FFA renders optimization algorithm invariant under all injective transformations of the objective function value.
  - FFA can prevent premature convergence to local optima.
  - FFA leads to an optimization process that explores the whole objective space.
  - FFA increases the chance of finding global optima.
- **Disadvantages:**
  - FFA makes the optimization process much slower, because the search effort is distributed evenly over the range of the objective function.
  - The slowdown caused by FFA seems to be proportional to the number of possible different objective values, i.e., is large if the objective function can take on many different values.
  - FFA requires a large number of objective function evaluations to reach good solution.
    100'000'000&nbsp;FEs is a reasonable *minimum* computational budget.
  - If a problem can already be solved reasonably well by a local search or EA, FFA will make them much slower.
- **Application Areas:**
  - FFA can be applied to combinatorial and discrete problems, but will not work for continuous domains.
  - The objective function should only be able to take on a few possible values, which is the case for many {% include taglink.liquid tag="MaxSat" %} instances, {% include taglink.liquid tag="packing" %} as well as for many {% include taglink.liquid tag="scheduling" %} problems.
  - It should be possible to perform many objective function evaluations, say 100'000'000, within a reasonable time.
  - If most candidate solutions have unique objective values, then FFA degenerates to a random walk, i.e., will perform very poorly.

As you can see, right now, we do not have a very wide range of problems where FFA will perform very well.
However, the unique properties of FFA, such as the invariance property and the simple fact that it actually works, make it highly interesting.
Consider this:
If we plug FFA into a simple (1+1)&nbsp;EA, this yields the (1+1)&nbsp;FEA which *does not prefer good solutions*, i.e., puts no search pressure towards finding better solutions.
Yet, it can solve the MaxSat problems much faster than the (1+1)&nbsp;EA.
Also, the (1+1)&nbsp;EA needs exponential runtime on deceptive benchmark problems like Trap, TwoMax, and Jump.
The (1+1)&nbsp;FEA solves them about as fast as the very simple OneMax problem, i.e., in experimentally observed polynomial runtime.
This odd approach to optimization deserves some more analysis.

## Publications
[Here](talks/ffa.pdf) you can find a [talk](talks/ffa.pdf) introducing FFA from the perspective of invariance properties.

### Core Papers
{::nomarkdown}{%- assign papers="WWLCL2023FFAOWBFGSCBE,WWLC2021FFAMOAIUBTOTOFV,WWWTDY2014FFA" | split: "," -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}

### Complete List
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.tags contains 'FFA'" -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}

{::nomarkdown}{%- capture myalgo -%}
First, we set $x\gets23^2$
Then, we compute $y=x^2-\log{x}$
For $i\gets 1$ to x:
@1: $y\gets y*i$
@1: $z\gets 3y$
EndFor
{%- endcapture -%}
{%- include algorithm.liquid text=myalgo -%}{:/}
