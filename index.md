---
layout: single
author_profile: true
read_time: false
comments: false
share: false
related: false
last_modified_at: 2026-02-08
---

This is the academic website of Dr.&nbsp;{%- include person.liquid person="weise_thomas" -%}, full professor at [Hefei University](https://www.hfuu.edu.cn/english)&nbsp;{%- include lang.liquid text="合肥大学" link="https://www.hfuu.edu.cn" %} located in the beautiful city of Hefei&nbsp;{%- include lang.liquid text="合肥市" %} in the Anhui Province&nbsp;{%- include lang.liquid text="安徽省" %} in China.

My [research area](/research/areas) is metaheuristic optimization and operations research.
I mainly focus on discrete and combinatorial problems from domains such as {% include taglink.liquid tag="logistics" %}, production planning, {% include taglink.liquid tag="scheduling" -%}, and {% include taglink.liquid tag="packing" -%}.

My current main research interest is a technique called *Frequency Fitness Assignment*&nbsp;({%- include taglink.liquid tag="FFA" -%}, {% include lang.liquid text="频率适应度分配" nowrap=true -%}), which is an "Algorithm Plugin" that removes the bias towards better solutions from its host algorithm and makes it invariant under all injective transformations of the objective function value.
This is the strongest theoretically possible invariance property and the only other algorithms that possess it are random sampling, random walks, and exhaustive enumeration.
These methods are very bad optimization methods.
Yet, if we plug it into the (1+1)&nbsp;EA, for instance, it leads to a speed-up of *three orders of magnitude* on the NP-hard MaxSat problem.
While I currently focus on finding the limits, advantages, drawbacks, and use cases of {% include taglink.liquid tag="FFA" %}, I also contribute to a [wide range of topics](/research/areas) in optimization.

Besides doing research, I [supervise great students](/teaching/supervision), [teach classes](/teaching), write [open source software](/software), sometimes give [talks](/talks), and contribute to the research community as [reviewer and editor](/research/activities).  
