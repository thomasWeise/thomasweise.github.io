---
title: "Optimization"
date: 2026-02-28
print_tag: "optimization"
layout: "tag"
permalink: "/tags/optimization"
use_math: true
---

Optimization is maybe the widest possible term for my research field.
It comprises all sorts of techniques and problems.
Basically, whenever we ask for a superlative, we have an optimization problem at hand.
Find the *shortest* round-trip tour through $n$&nbsp;cities?
That's an {% include taglink.liquid tag="TSP" tag_text="optimization problem" %}.
Assign jobs to machines such that all customer orders are fixed as quickly as possible?
That's an {% include taglink.liquid tag="JSSP" tag_text="optimization problem" %}.
If you ask me, basically all machine learning and AI tasks can be classified as optimization problems, too.

In this very wide field, many algorithms have emerged.
As sub-field, we have {% include taglink.liquid tag="metaheuristics" %} that can yet be subdivided into, for instance, {% include taglink.liquid tag="local_search" %}&nbsp;(including, e.g., {% include taglink.liquid tag="RLS" %}, {% include taglink.liquid tag="SA" %}, and {% include taglink.liquid tag="tabu_search" %}), {% include taglink.liquid tag="EC" tag_text="evolutionary computation" %} methods&nbsp;(such as&nbsp;{% include taglink.liquid tag="EAs" %}, {% include taglink.liquid tag="GAs" %}, and {% include taglink.liquid tag="MAs" %}) and {% include taglink.liquid tag="si" tag_text="swarm intelligence" %} methods&nbsp;(most prominently, {% include taglink.liquid tag="ACO" %} and {% include taglink.liquid tag="PSO" %}).
Then there are exact methods like {% include taglink.liquid tag="bab" tag_text="branch and bound" %} and many other approaches.

All of them have in common that they exist to tackle some classes of the many problems that emerge in optimization, including the&nbsp;{% include taglink.liquid tag="TSP" %}, {% include taglink.liquid tag="QAP" %}, {% include taglink.liquid tag="TTP" %}, {% include taglink.liquid tag="BPP" %}, {% include taglink.liquid tag="CARP" %}, {% include taglink.liquid tag="VRP" %}, and a variety of other {% include taglink.liquid tag="packing" %}, {% include taglink.liquid tag="scheduling" %}, and {% include taglink.liquid tag="logistics" %} tasks.
Of course, optimization applies also to many fields in engineering and design.
