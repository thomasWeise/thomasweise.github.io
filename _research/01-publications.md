---
title: "Publications"
permalink: /research/publications
read_time: false
toc: true
author_profile: true
---

{% assign total = 0 -%}
{%- assign first_author = 0 -%}
{%- assign total_article = 0 -%}
{%- assign first_author_article = 0 -%}
{%- assign total_conference = 0 -%}
{%- assign first_author_conference = 0 -%}
{%- assign total_book = 0 -%}
{%- assign total_proceedings = 0 -%}
{%- assign total_chapter = 0 -%}
{%- for paper in site.data.publications -%}
    {%- assign total = total | plus: 1 -%}
    {%- assign fa = paper.authors[0] -%}
    {%- if fa == "weise_thomas" -%}
        {%- assign first_author = first_author | plus: 1 -%}
    {%- endif -%}
    {%- case paper.type -%}
        {%- when "article" -%}
            {%- assign total_article = total_article | plus: 1 -%}
            {%- if fa == "weise_thomas" -%}
                {%- assign first_author_article = first_author_article | plus: 1 -%}
            {%- endif -%}
        {%- when "conference" -%}
            {%- assign total_conference = total_conference | plus: 1 -%}
            {%- if fa == "weise_thomas" -%}
                {%- assign first_author_conference = first_author_conference | plus: 1 -%}
            {%- endif -%}
        {%- when "book" -%}
            {%- assign total_book = total_book | plus: 1 -%}
        {%- when "proceedings" -%}
            {%- assign total_proceedings = total_proceedings | plus: 1 -%}
        {%- when "chapter" -%}
            {%- assign total_chapter = total_chapter | plus: 1 -%}    
    {%- endcase -%}
{%- endfor -%}

Prof.&nbsp;Dr.&nbsp;{%- include person.liquid person=site.data.people.weise_thomas %} has published {{ total -}}&nbsp;works, including {{ total_article -}}&nbsp;articles, {{ total_conference -}}&nbsp;conference papers, {{ total_book -}}&nbsp;books, {{ total_chapter -}}&nbsp;book chapters, and {{ total_proceedings -}}&nbsp;edited proceedings.
He is the first author of&nbsp;{{ first_author -}}&nbsp;of these works, including {{ first_author_article -}}&nbsp;articles and {{ first_author_conference -}}&nbsp;conference papers.

## Scholarly Profiles
Several facets of my research work can also be accessed from the following profiles:

- <a href="http://scholar.google.com/citations?user=rT9StgcAAAAJ">Google Scholar</a>
- <a href="https://www.kiphub.com/author/666223137bda79841927fc0d">KipHub Scholarly</a>
- <a href="https://dblp.org/pid/38/1046">DBLP</a>
- <a href="https://www.semanticscholar.org/author/8950208">SemanticScholar</a>
- <a href="https://www.researchgate.net/profile/Thomas-Weise-3">ResearchGate</a>
- <a href="https://dl.acm.org/profile/81317502373">ACM Author Page</a>
- <a href="https://ieeexplore.ieee.org/author/37297069700">IEEE Author Page</a>
- ORCID:&nbsp;<a href="https://orcid.org/0000-0002-9687-8509">0000-0002-9687-8509</a>
- <a href="https://arxiv.org/a/0000-0002-9687-8509.html">arXiv</a>
- <a href="http://gpbib.cs.ucl.ac.uk/gp-html/ThomasWeise.html">GP Bibliography</a>

## 2025
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.year==2025" -%}{%- include publications.liquid papers=papers -%}{:/}
## 2024
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.year==2024" -%}{%- include publications.liquid papers=papers -%}{:/}
## 2023
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.year==2023" -%}{%- include publications.liquid papers=papers -%}{:/}
## 2022
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.year==2022" -%}{%- include publications.liquid papers=papers -%}{:/}
## 2021
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.year==2021" -%}{%- include publications.liquid papers=papers -%}{:/}
## 2020
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.year==2020" -%}{%- include publications.liquid papers=papers -%}{:/}
## 2019
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.year==2019" -%}{%- include publications.liquid papers=papers -%}{:/}
## 2018
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.year==2018" -%}{%- include publications.liquid papers=papers -%}{:/}
## 2017
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.year==2017" -%}{%- include publications.liquid papers=papers -%}{:/}
## 2016
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.year==2016" -%}{%- include publications.liquid papers=papers -%}{:/}
## 2015
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.year==2015" -%}{%- include publications.liquid papers=papers -%}{:/}
## 2014
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.year==2014" -%}{%- include publications.liquid papers=papers -%}{:/}
## 2013
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.year==2013" -%}{%- include publications.liquid papers=papers -%}{:/}
## 2012
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.year==2012" -%}{%- include publications.liquid papers=papers -%}{:/}
## 2011
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.year==2011" -%}{%- include publications.liquid papers=papers -%}{:/}
## 2010
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.year==2010" -%}{%- include publications.liquid papers=papers -%}{:/}
## 2009
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.year==2009" -%}{%- include publications.liquid papers=papers -%}{:/}
## 2008
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.year==2008" -%}{%- include publications.liquid papers=papers -%}{:/}
## 2007
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.year==2007" -%}{%- include publications.liquid papers=papers -%}{:/}
## 2006
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.year==2006" -%}{%- include publications.liquid papers=papers -%}{:/}
## 2005
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.year==2005" -%}{%- include publications.liquid papers=papers -%}{:/}
