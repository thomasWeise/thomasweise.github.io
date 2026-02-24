---
title: "Scheduling"
permalink: /research/areas/scheduling
read_time: false
toc: false
author_profile: true
date: 2026-02-10
last_modified_at: 2026-02-10
tags: ["optimization", "scheduling"]
---

Scheduling is the wide area of determining when things should be done.
It is clear that scheduling intersects directly with {% include taglink.liquid tag="logistics" -%} and {% include taglink.liquid tag="packing" -%}.
Application areas also include production planning, crew scheduling, or timetabling.
Together with friends, I also contributed one or two works to this domain.

{% assign scheduling=site.data.publications | where_exp: "item", "item.tags contains 'scheduling'" -%}

## Publications
{::nomarkdown}{%- include publications.liquid papers=scheduling shorter=true -%}{:/}
