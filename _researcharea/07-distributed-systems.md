---
title: "Distributed Systems"
permalink: /research/areas/distributed-systems
read_time: false
toc: true
author_profile: true
---

Distributed systems comprise a wide range of interacting components, such as computer networks, network applications, or multi-agent systems.
Since I did my PhD at the [Distributed Systems Group](http://www.uni-kassel.de/eecs/vs) of  the [University of Kassel](http://www.uni-kassel.de) (德国卡塞尔大学), naturally, this is also one of my research interests.
 
{% assign ds=site.data.publications | where_exp: "item", "item.tags contains 'distributed_systems'" -%}

## Algorithm Synthesis
My PhD research aimed at {% include taglink.liquid tag="algorithm_synthesis" tag_text="syntesizing algorithm" -%} for distributed systems.
In a computer network, the nodes may perform tasks such as election or may implement some form of mutual exclusion when accessing a shared resource.
In a wireless sensor network, they may try to aggregate information and compute statistics in a distributed fashion.
I tried to automatically generate algorithms for such tasks using {% include taglink.liquid tag="GP" tag_text="Genetic Programming" %}, with some minor success-
{%- assign algopapers=ds | where_exp: "item", "item.tags contains 'algorithm_synthesis'" -%}
{::nomarkdown}{%- include publications.liquid papers=algopapers shorter=true -%}{:/}

## Web Services
{% include taglink.liquid tag="web_services" tag_text="Web Services" %} are another interesting topic in distributed systems.
Here, I was part of our team's participants of the international web service challenge, which tried to find efficient ways to compose semantically annotated web services in the mid-2000s.
We won that challenge in 2006, scored second in 2007, and third in 2008.
{%- assign ws=ds | where_exp: "item", "item.tags contains 'web_services'" -%}
{::nomarkdown}{%- include publications.liquid papers=ws shorter=true -%}{:/}

## Other Topics
Besides working on distributed algorithm synthesis and web services, I also contributed to several other domains of distributed systems, including {% include taglink.liquid tag="routing" %}, {% include taglink.liquid tag="VNF" tag_text="virtual network function" %} placement, and {% include taglink.liquid tag="robotics" -%}.
{%- assign other=ds -%}
{%- for pa in algopapers -%}
    {%- assign other=other | where_exp: "item", "item != pa" -%}
{%- endfor -%}
{%- for pb in ws -%}
    {%- assign other=other | where_exp: "item", "item != pb" -%}
{%- endfor -%}
{::nomarkdown}{%- include publications.liquid papers=other shorter=true -%}{:/}
