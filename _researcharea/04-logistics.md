---
title: "Logistics"
permalink: /research/areas/logistics
read_time: false
toc: true
author_profile: true
---

Logistics is a huge area that poses a wide range of different optimization problems.
It comprises many sub-fields, ranging from classical tasks like the {% include taglink.liquid tag="TSP" %} to more general problems that are very constraint and specific to a particular company.
I have contributed to many of these fields.

## Traveling Salesperson Problem&nbsp;(TSP)
The most classical logistics task is the Traveling Salesperson Problem&nbsp;({% include taglink.liquid tag="TSP" %}), which is one of the most classical NP-hard problems from operations research.
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.tags contains 'TSP'" -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}

## Vehicle Routing Problems&nbsp;(VRPs)
Vehicle Routing Problems&nbsp;({% include taglink.liquid tag="VRP" tag_text="VRPs" %}) are a much wider task than {% include taglink.liquid tag="TSP" tag_text="TSPs" %}.
While the TSP aims to route a single vehicle through several locations only considering the total travel distance, VRPs may involve multiple vehicles, time windows for pickup and delivery of goods from locations, capacity constraints, and even different vehicles such as trucks and trains.
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.tags contains 'VRP'" -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}

## Traveling Tournament Problem&nbsp;(TTP)
The Traveling Tournament Problem&nbsp;({% include taglink.liquid tag="TTP" %}) is special logistics task.
Here, the goal is to design tournament plans where teams from different cities visit each other.
Each team usually plays every other team twice, once at home and once in the stadium of the other team.
The schedule should be both efficient (with a low overall travel distance) and fair (obeying several constraints).
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.tags contains 'TTP'" -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}

## Arc Routing Problems
Arc Routing Problems are logistic planning problems where the goal is to find optimal routes for vehicles that need to visit certain streets which require some treatment.
In Capacitated Arc Routing Problems&nbsp;({% include taglink.liquid tag="CARP" tag_text="CARPs" %}), the vehicles are initially located at a single depot and have to deliversome product (such as salt or mail) to the roads.
This product is available at the depot at a sufficient amount.
The vehicles are limited in their capacity, i.e., the amount of product that they can transport.
Traversing any road takes a certain time (cost) and the goal is to find tours of minimum cost that satisfy all requirements.
{::nomarkdown}{%- assign papers=site.data.publications | where_exp: "item", "item.tags contains 'VRP'" -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}
