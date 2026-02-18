---
title: "Traveling Salesperson Problem"
permalink: /research/areas/tsp
read_time: false
toc: true
author_profile: true
date: 2026-02-06
last_modified_at: 2026-02-18
use_math: true
---

The Traveling Salesperson Problem&nbsp;(TSP) is one of the most important combinatorial optimization tasks, one of the classical tasks from the field of Operations Research.
Here, the goal is to find the shortest round-trip tour through $n$&nbsp;cities and back to the origin.
A TSP instance is defined by the number of cities and their distances.
In a symmetric instance, the distance from $A$ to $B$ is the same as the distance from $B$ to $A$, in an asymmetric instance, this is not necessarily true.

## Publications
### Core Papers
{% assign thepapers = "WCLTTCMY2014BOAAOSFFTTSP,WWCTL2016GVLSTIOPSOEAP,WWLC2019IIIOADTM" | split: "," -%}
{%- include publications.liquid papers=thepapers shorter=true %}

## Complete List
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.tags contains 'TSP'" -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}
