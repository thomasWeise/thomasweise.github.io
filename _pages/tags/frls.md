---
title: "Randomized Local Search with Frequency Fitness Assignment (FRLS)"
date: 2026-02-27
print_tag: "FRLS"
layout: "tag"
permalink: "/tags/frls"
tags: ["metaheuristics", "local_search", "RLS", "FFA"]
---

Randomized local search&nbsp;({% include taglink.liquid tag="rls" %}) is maybe the simplest {% include taglink.liquid tag="local_search" %} algorithm.
It maintains one single best-so-far solution and in each step, it samples one new solution by applying the unary search operator to it.
It will accept the new solution as the current solution if it is not worse.
If we plug Frequency Fitness Assignment&nbsp;({% include taglink.liquid tag="ffa" %}) into this algorithm, we obtain the FRLS.
