---
title: "Benchmarking"
permalink: /research/areas/benchmarking
read_time: false
toc: true
author_profile: true
---

In the field of optimization, benchmarking is the research area focussed on how to investigate algorithm performance experimentally.
The goal is to get a reliable and replicable impression of how good and how efficient algorithms are.
This then serves as foundation for the decision which algorithm to use for a given real-world problem and/or how we may improve performance by research.
Since this research direction is a mixture of experiments and statistics, it gives me a chance to do some programming for research (yeah!) and contribute packages like [moptipy](/moptipy) which practically implement theoretically-grounded best practices into industry-grade software based on many years of experience. 

## Introduction
Optimization problems usually are not singular tasks that can be solved once and then everyone is happy.
Instead, they are classes of tasks.
The Traveling Salesperson Problem&nbsp;({%- include taglink.liquid tag="TSP" -%}), for example, asks us to find the shortest round-trip tour through *n*&nbsp;cities.
Each instance of the TSP may have a different number of cities and cities at different locations.
Thus, we cannot solve "The TSP," but instead develop algorithms that can solve TSPs.

Now, since every instance of the TSP may be different, it is hard to say which algorithm is really good.
Maybe we have an algorithm that can only solve instances with specific properties and performs really bad on others.
Or maybe we have one algorithm that is fast, but its solution quality is not so good, and another algorithm that is slow, but usually delivers good solutions.
Maybe we even have an algorithm that can solve both TSPs and Quadratic Assignment Problems&nbsp;({%- include taglink.liquid tag="QAP" tag_text="QAPs" -%}), but pays for this with slightly lower solution quality or longer runtime.
Thus, the question which algorithms are good, or reliably good, generally good, fast, or efficient is not always easy to answer.

This is the field of benchmarking.
We use experiments to investigate algorithm performance.
We try to do this in a statistically sound and replicable way.
And I have worked on this field for quite some years.
For example, I have [organized several workshops](/research/events) on the topic at international conferences.
I also give [talks](/talks) related to it.
And I contributed heaps of open source software, ranging from the modern [moptipy](/moptipy) {% include taglink.liquid tag="Python" %} package over the {% include taglink.liquid tag="TSPSuite" %} and the {% include taglink.liquid tag="optimizationBenchmarking" %} packages to the early [AOAB](/research/publications#WNT2010AAOAB) and the yet-earlier [DGPF](/research/publications#WG2006DAAFFDMOSAATTGPOSN).

## Publications
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.tags contains 'benchmarking'" -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}
