---
title: "Paper Accepted at GECCO: When Frequency Fitness Assignment Fails: Trapped States in Frequency-Guided Local Search"
date: 2026-04-06
last_modified_at: 2026-04-06
use_math: true
tags: ["FFA", "metaheuristics", "optimization"]
---

Our paper&nbsp;*When Frequency Fitness Assignment Fails: Trapped States in Frequency-Guided Local Search* has been accepted at the Genetic and Evolutionary Computation Conference&nbsp;([GECCO'2026](https://gecco-2026.sigevo.org)) taking place from July&nbsp;13 to&nbsp;17, 2026 in San José, Costa Rica.
 
{::nomarkdown}{%- assign papers="ZWWW2026WFFAFTSIFGLS" | split: "," -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}

## Introduction
Frequency Fitness Assignment&nbsp;({%- include taglink.liquid tag="FFA" -%}, {% include lang.liquid text="频率适应度分配" nowrap=true -%}) is an "algorithm plugin" that *fundamentally* changes how the selection step in {% include taglink.liquid tag="metaheuristics" %} works.
We already discussed the [invariance properties]({%- post_url 2026-02-28-ffa-invariance -%}) of FFA and [how FFA can be plugged]({%- post_url 2026-02-23-plugging-ffa-into-metaheuristics -%}) into {% include taglink.liquid tag="local_search" %} in previous posts.

In the paper, we investigate several objective-guided and FFA-guided optimization methods as well as their hybrids to a wide variety of discrete of benchmark functions.
Discrete benchmark functions&nbsp;$f:\mathbb{X}\mapsto\mathbb{N}$ are defined over a search space&nbsp;$\mathbb{X}=\{0,1\}^n$ composed of $n$-dimensional bit strings and compute integer results.
There exist very simple benchmarks, like OneMax, where the goal is to maximize the number of `1`&nbsp;bits in the strings.
There also are hard benchmarks, like the Trap function, which is similar to OneMax but where the "gradient" is flipped so that it points away from the optimum.

## Interesting New Findings
In our new paper, we make some interesting findings:
First, FFA is designed to be maximally explorative.
We expected that it would produce a search that could never prematurely converge, a search that would keep exploring the search space forever.
In the paper, we proof the exact conditions under which FFA can get stuck.
We show that this might even happen in a very simple scenario:
The {%- include taglink.liquid tag="FRLS" -%}, i.e., the {%- include taglink.liquid tag="RLS" -%} with a search operator always flipping exactly one bit, can get stuck on OneMax.

Second, we also tackled the low-autocorrelation binary sequence problem&nbsp;(LABS).
This is the $\mathcal{NP}$-hard problem of finding a binary sequence of length&nbsp;$n$ whose autocorrelation is as low as possible.
We wanted to use it as a benchmark, but discovered several new best-known solutions for some&nbsp;$n\geq600$.

Finally, in the hybrid algorithms combining FFA- and objective-guided search, we introduced a binary operator, i.e., uniform crossover, to transfer information from the FFA-guided to the objective-guided algorithm strand.
We find that this works actually quite well.

All of that can be found in our paper, which we will present this July.

## Further Reading
{::nomarkdown}{%- assign papers="WWLCL2023FFAOWBFGSCBE,WWLC2021FFAMOAIUBTOTOFV,ZWWW2026WFFAFTSIFGLS" | split: "," -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}
