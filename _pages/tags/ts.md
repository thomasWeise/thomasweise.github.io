---
title: "Tabu Search"
date: 2026-02-27
print_tag: "tabu_search"
layout: "tag"
permalink: "/tags/ts"
tags: ["metaheuristics", "local_search", "RLS"]
---

Tabu search is a {% include taglink.liquid tag="local_search" %} algorithm that tries to avoid converging to a local optimum by declaring some previously visited solutions or solution sub-structures as "tabu."
Solutions that are "tabu" must not be visited by the search, which therefore is less likely to get stuck or to drop into a cycle of resampling the same solutions again and again.
We can consider Tabu search as a randomized local search&nbsp;({% include taglink.liquid tag="RLS" %}) to which the tabu criterion is added.
