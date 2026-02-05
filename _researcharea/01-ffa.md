---
title: "Frequency Fitness Assignment"
permalink: /research/areas/ffa
read_time: false
toc: true
author_profile: true
---

Frequency Fitness Assignment&nbsp(FFA, 频率适应度分配) is a novel approach to metaheuristic optimization.
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

Dropping the bias towards better solutions has an interesting consequence:
Algorithms that use FFA are invariant under all injective transformations of the objective function value.
This is the strongest theoretically possible invariance property.
The only other algorithms that have it are random sampling, random walks, and exhaustive enumeration.
These methods, however, are pretty awful approaches to optimization.
Not FFA, though, as it turned out to work quite well in domains such as MaxSat, the Traveling Salesperson Problem, the Quadratic Assignment Problem, and on discrete benchmark functions.

## Publications
[Here](talks/ffa.pdf) you can find a [talk](talks/ffa.pdf) introducing FFA from the perspective of invariance properties.

### Core Papers
{::nomarkdown}{%- assign papers="WWLCL2023FFAOWBFGSCBE,WWLC2021FFAMOAIUBTOTOFV,WWWTDY2014FFA" | split: "," -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}

### Complete List
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.tags contains 'FFA'" -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}
