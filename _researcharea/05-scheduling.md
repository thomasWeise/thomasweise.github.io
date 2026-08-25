---
title: "Scheduling"
permalink: /research/areas/scheduling
read_time: false
toc: false
author_profile: true
tags: ["optimization", "scheduling"]
last_modified_at: 2026-03-16
---

Scheduling is the wide area of {% include taglink.liquid tag="or" tag_text="Operations Research" %} with the general goal of determining in which sequence and/or when things should be done.
It is clear that scheduling intersects directly with {% include taglink.liquid tag="logistics" -%} and {% include taglink.liquid tag="packing" -%}.
Application areas also include production planning, crew scheduling, or timetabling.
Together with friends, I also contributed one or two works to this domain.

{% assign scheduling=site.data.publications | where_exp: "item", "item.tags contains 'scheduling'" -%}

## Publications
{::nomarkdown}{%- include publications.liquid papers=scheduling shorter=true -%}{:/}
