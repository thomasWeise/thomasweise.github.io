---
title: "Publications"
permalink: /research/publications
read_time: false
toc: false
author_profile: true
---

<ol>
{% for paper in site.data.publications %}
  <li>{{ paper.authors | join: ", " }}. {{paper.citation}}. {{paper.links}}.</li>
{% endfor %}
</ol>
