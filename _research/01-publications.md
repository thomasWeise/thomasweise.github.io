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
  {% for author in paper.authors %}{{site.data.people[author] | markdownify | remove: '<p>' | remove: '</p>' | strip}}{% unless forloop.last %}, {% endunless %}{% endfor %}.
  {{paper.citation | markdownify | remove: '<p>' | remove: '</p>' | strip}}.
  {{paper.links | markdownify | remove: '<p>' | remove: '</p>' | strip}}.</li>
{% endfor %}
</ol>
