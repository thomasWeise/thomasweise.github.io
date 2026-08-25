---
title: "Memetic Algorithms (MAs)"
date: 2026-02-27
print_tag: "MAs"
layout: "tag"
permalink: "/tags/mas"
tags: ["metaheuristics", "EAs", "EC"]
use_math: true
---

Memetic Algorithms&nbsp;(MAs) are basically Evolutionary Algorithms&nbsp;({% include taglink.liquid tag="eas" %}) with {% include taglink.liquid tag="local_search" %} plugged in.
In the most basic form, the EA is "outer" or "main" algorithm.
To each solution that it samples, a local search is applied.
The result of the local search then enters the population.
