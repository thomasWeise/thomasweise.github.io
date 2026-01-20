---
title: "Publications"
permalink: /research/publications
read_time: false
toc: false
author_profile: true
---

<ol>
{% for paper in site.data.publications %}
  <li>
  {% for author in paper.authors %}{{site.data.people[author]}}{% unless forloop.last %},{% endunless %}{% endfor %}.
  {{paper.citation}}.
  {{paper.links}}.</li>
{% endfor %}
</ol>
