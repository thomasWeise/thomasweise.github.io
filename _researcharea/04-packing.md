---
title: "Packing and Cutting Problems"
permalink: /research/areas/packing
read_time: false
toc: true
author_profile: true
last_modified_at: 2026-02-08
---

Packing is a research field very closely related to {% include taglink.liquid tag="logistics" -%}.
Here, the goal is to pack objects of certain sizes into containers of given sizes.
The objects may be one-, two-, or three-dimensional.
It may or may not be permitted to rotate them when packing them.
Often, the goal is to use as few containers as possible.

Cutting is very similar to packing, but now the goal is to cut objects of certain sizes from a substrate.
Clearly, packing and cutting proglems can be transformed into each other.

## Publications
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.tags contains 'packing'" -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}
