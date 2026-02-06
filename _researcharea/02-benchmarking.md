---
title: "Benchmarking"
permalink: /research/areas/benchmarking
read_time: false
toc: true
author_profile: true
---

## Introduction
Optimization problems usually are not singular tasks that can be solved once and then everyone is happy.
Instead, they are classes of tasks.
The Traveling Salesperson Problem&nbsp;({%- include taglink.liquid tag="TSP" -%}), for example, asks us to find the shortest round-trip tour through *n*&nbsp;cities.
Each instance of the TSP may have a different number of cities and cities at different locations.
Thus, we cannot solve "The TSP," but instead develop algorithms that can solve TSPs.

Now, since every instance of the TSP may be different, it is hard to say which algorithm is really good.
Maybe we have an algorithm that can only solve instances with specific properties and performs really bad on others.
Or maybe we have one algorithm that is fast, but its solution quality is not so good, and another algorithm that is slow, but usually delivers good solutions.
Maybe we even have an algorithm that can solve both TSPs and Quadratic Assignment Problems&nbsp;({%- include taglink.liquid tag="QAP" tag_text="QAPs -%}), but pays for this with slightly lower solution quality or longer runtime.
Thus, the question which algorithms are good, or reliably good, generally good, fast, or efficient is not always easy to answer.

This is the field of benchmarking.
We use experiments to investigate algorithm performance.
We try to do this in a statistically sound and replicable way.
And I have worked on this field for quite some years.
For example, I have [organized several workshops](/research/events) on the topic at international conferences.
And I also give [talks](/talks) related to it.

## Publications
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.tags contains 'benchmarking'" -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}
