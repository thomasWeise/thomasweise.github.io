---
title: "Publications"
permalink: /research/publications
read_time: false
toc: false
author_profile: true
---

<ol>
{% for paper in site.data.publications %}
  <li>{% include "publication" with paper as paper %}</li>
{% endfor %}
</ol>
