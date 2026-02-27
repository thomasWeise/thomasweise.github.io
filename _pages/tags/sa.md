---
title: "Simulated Annealing (SA)"
date: 2026-02-27
print_tag: "SA"
layout: "tag"
permalink: "/tags/sa"
tags: ["metaheuristics", "local_search", "RLS"]
---

Simulated Annealing&nbsp;(SA) is a {% include taglink.liquid tag="local_search" %} algorithm that tries to avoid converging to a local optimum by sometimes accepting worse solutions.
The probability to accept worse solutions declines over time based on a temperature schedule.
At any point in time, the search has a so-called "temperature."
The higher the temperature, the more likely it is to accept a worse solution.
Also, a worse solution is more likely to be accepted if its objective value is not much worse than the current solution.
The temperature declines over time, usually in an exponential manner.
We can consider SA as a randomized local search&nbsp;({% include taglink.liquid tag="RLS" %}) to which the temperature-based acceptance was added.
