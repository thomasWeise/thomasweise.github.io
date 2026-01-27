---
layout: single
author_profile: true
read_time: false
comments: false
share: false
related: false
---

This is the academic website of Dr.&nbsp;{%- include person.liquid person="weise_thomas" -%}, full professor at [Hefei University](https://www.hfuu.edu.cn/english)&nbsp;([合肥大学](https://www.hfuu.edu.cn)) located in the beautiful city of Hefei&nbsp;(合肥市) in the Anhui Province&nbsp;(安徽省) in China.

My research interests are in optimization, operations research, and metaheuristics.
I mainly focus on discrete and combinatorial from domains such as transport and logistics, production planning, scheduling, and packing.
Within these domains, I currently pursue two main interests.

My first research interest is on a technique called *Frequency Fitness Assignment&nbsp;(FFA, 频率适应度分配), which is an "Algorithm Plugin".
FFA removes the bias towards better solutions from its host algorithm and makes it invariant under all injective transformations of the objective function value.
This is the strongest theoretically possible invariance and the only other algorithms that possess it are random sampling, random walks, and exhaustive enumeration.
These methods are very bad optimization methods.
Yet, if we plug it into the (1+1)&nbsp;EA, for instance, it can speed the algorithm up by three orders of magnitude on the NP-hard MaxSat problem.
My goal is to research both positive and negative aspects of FFA.
Some of my publications on this topic are:

{% assign thepapers = "WWLCL2023FFAOWBFGSCBE,WWLC2021FFAMOAIUBTOTOFV,WWWTDY2014FFA" | split: "," -%}
{%- include publications.liquid papers=thepapers shorter=true %}

My second research interest is on benchmarking.
Benchmarking is maybe the most important tool for experimental research on metaheuristics.
We need proper tools to run replicable and self-documenting experiments.
If we have those, then we can gather lots of meaningful data.
Once we have lots and lots of data, the question of how to make sense out of it emerges.
This can, again, be done with tools, statistics, or even artificial intelligence.
