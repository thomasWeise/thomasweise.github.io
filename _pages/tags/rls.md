---
title: "Randomized Local Search (FRLS)"
date: 2026-02-27
print_tag: "RLS"
layout: "tag"
permalink: "/tags/rls"
tags: ["metaheuristics", "local_search", "FRLS"]
---

Randomized local search&nbsp;(RLS) is maybe the simplest {% include taglink.liquid tag="local_search" %} algorithm.
It maintains one single best-so-far solution and in each step, it samples one new solution by applying the unary search operator to it.
It will accept the new solution as the current solution if it is not worse.
This search works already surprisingly well on a wide set of optimization problems.
It can be viewed as the bottom line that any new {% include taglink.liquid tag="metaheuristic" %} must significantly outperform to be worth its salt.
If we plug Frequency Fitness Assignment&nbsp;({% include taglink.liquid tag="ffa" %}) into this algorithm, we obtain the {% include taglink.liquid tag="frls" %}.
