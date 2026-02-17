---
title: "Teaching"
permalink: /research/areas/teaching
read_time: false
toc: false
author_profile: true
date: 2026-02-07
last_modified_at: 2026-02-10
---

Teaching lies on the fringes of my research interests.
One of the very first research-related works I did was actually the development of a what-you-see-is-what-you-get editor for teaching material.
Even now, I am still creating my own systems for generating teaching material and used them two write books and slides for my own classes.
The latest iteration of this never-ending struggle is using GitHub actions to build teaching material located in GitHub repositories and a [LaTeX/Python package](/software/texgit) from including data from other repositories in such material.
I used this material to write my books [Programming with Python](/programmingWithPython) and [Databases](/databases) in 2025.
So I do not really research on <em>how to teach</em> or <em>what to teach</em>, but I do think that my tinkering with tools and software may count as research on <em>how to create teaching material</em>.

{% assign papers=site.data.publications | where_exp: "item", "item.tags contains 'teaching'" -%}
{::nomarkdown}{%- include publications.liquid papers=papers shorter=true -%}{:/}
