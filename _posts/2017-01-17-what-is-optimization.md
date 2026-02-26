---
title: "What is optimization?"
date: 2017-01-17
last_modified_at: 2026-02-26
tags: ["optimization", "metaheuristics", "TSP", "local_search", "EC"]
use_math: true
images: ["function_growth", "runtime_quality_tradeoff"]
---
The center of my research is *{%- include taglink.liquid tag="optimization" -%}*.
But what is optimization?
Basically, optimization is the art of making good decisions.
It provides us with a set of tools, mostly from the areas of computer science and mathematics, which are applicable in virtually all fields ranging from business, industry, biology, physics, medicine, data mining, engineering, to even art.

Every question that asks for a thing with a superlative feature is an optimization problem.
Constructing the fastest car, finding the most profitable investment plan, finding a way to discover diseases as early and reliable as possible, scheduling your work so that you have the most spare time left for gaming -- all of these are optimization tasks.

In this post, we will explore what an optimization problem in more detail.
We will distinguish hard from easy problems and discuss what implications come from "hardness."
We will discuss how exact and approximate algorithms tackle hard problems, give a slightly more formal definition of optimization problem, and list some more examples for optimization tasks.

Both our professional and private lives are sequences of decisions and each decision involves choosing between at least two options&nbsp;(otherwise we can hardly call it a decision).
Amongst the possible choices, we search for the best, the optimal one.
Any such search can be formulated as optimization problem, which has at least two major components:

- A set&nbsp;$\mathbb{X}$ of possible choices&nbsp;$x\in\mathbb{X}$.
  $\mathbb{X}$&nbsp;is called the solution space, since each choice&nbsp;$x$ would be a potential "solution" to the problem.
  The elements&nbsp;$x$ are called the candidate solutions.
- Some way to compare two solutions $x_1, x_2\in\mathbb{X}$ in order to tell which one is better.

## What is Problem Hardness?
Naturally, we would like to find the best solution&nbsp;$x^{\star}\in\mathbb{X}$.
There are quite a few problems where we can do this directly.
For instance, if we have 100&nbsp;coins and want to purchase as much cake as possible in a situation where one piece of cake costs 10&nbsp;coins, we can directly and easily derive the solution&nbsp;$x^{\star}=10$.

### Time Complexity
Then there may be optimization problems where we cannot get the solution as result of directly solving a single equation, but by using an algorithm.
Finding the shortest paths from one city to all $n-1$&nbsp;other cities on a map is clearly an optimization task -- which can directly be solved using Dijkstra's algorithm.
Such algorithms need a certain number of "steps" to finish.
In case of a basic implementation of Dijkstra's algorithm, that number is roughly proportional to&nbsp;$n^2$.
In other words, the more cities we have, the longer it will take to find all the shortest path.
The needed time will grow roughly quadratically with the number of cities.

The relationship between the "size and features" of a problem and the time needed to solve it is called (time) complexity.
For each problem, we want to use the best method (algorithm) to solve it.
For different problems, there are different best algorithms and these have a different time complexity.

### Simple Problems: Polynomial Time Complexity
As first example, consider sorting a set of $n$&nbsp;numbers.
This can be done in the scale of {::nomarkdown}$n\log{n}${:/}&nbsp;steps.
As second example, assume that we have map with $e$&nbsp;streets and $v$&nbsp;intersections.
We know how many cars can go on each street per minute.
The maximum amount of cars which can drive from a source intersection&nbsp;$A$ to a target intersection&nbsp;$B$ can be determined using the Edmonds-Karp algorithm within a number of steps roughly proportional to&nbsp;{::nomarkdown}$v*e^2${:/}.

Clearly, the number of steps we need to get the solution of these problems depends on their size&nbsp;(called scale).
The more streets we have on the map, the longer it takes to find how many cars we can send from&nbsp;$A$ to&nbsp;$B$ per time unit.
The more elements we want to sort, the longer the sorting will take.
As long as the number of required steps of an algorithm does not grow much faster than a reasonable polynomial, say&nbsp;$n^4$, we can solve the problem by throwing more hardware on it.

### Hard Problems: Exponential Time Complexity
Unfortunately, there is a class of problems where the number of steps needed to&nbsp;(guarantee to get) get the exact globally best solution may rise exponentially with the problem scale&nbsp;(in the worst case)!

{% include image.liquid src="/assets/images/function_growth.svg" caption="A log-log-scaled plot of different functions (including polynomially and exponentially growing ones as well as the factorial) to illustrate the speed of growth of these functions." id="function_growth" %}

What this means is that if you have such a problem of a reasonable size and want to get the best-possible solution, you may need to wait far too long.
And there are many such problems, including the following examples:

- the Boolean Satisfiability Problem, asking whether and how a given Boolean formula can become&nbsp;`true` , which is quite important for circuit design, for instance,
- the Bin {% include taglink.liquid tag="packing" tag_text="Packing" %} Problem&nbsp;({%- include taglink.liquid tag="BPP" -%}), asking for the minimum number of containers needed to package a certain set of&nbsp;(differently-sized) items, which has quite obvious applications in {% include taglink.liquid tag="logistics" %},
- the Knapsack Problem, asking for the maximum sum value of items&nbsp;(selected from a specific set of items with different values and sizes) we can pack into a given volume, too, has quite a lot of obvious applications,
- the Set Covering Problem, where a set of subsets is given and we want to find the minimum number of subsets whose union still covers all the elements in all subsets, which can be visualized as, e.g., the question where to put base stations in a mobile network or a situation where a company needs to purchase a certain set of supplies and different contractors offer different deals, each containing some of the supplies,
- in Graph Coloring, we ask for the minimum number of colors to be assigned to the nodes of a given graph so that no two nodes connected by an edge have the same color, which has applications, for instance, in the register allocation during the code optimization of program compilation,
- in the Quadratic Assignment Problem&nbsp;({%- include taglink.liquid tag="QAP" -%}), we have $n$&nbsp;workshops that need to be assigned to $n$&nbsp;locations.
  We know the flows of goods between the workshops and the distances between the locations and want to find an assignment with minimal total sum of the product of flow and distance.
- A huge variety of logistics problems, such as the Route Inspection Problem, the Vehicle Routing Problem&nbsp;({%- include taglink.liquid tag="VRP" -%}), Capacitated Arc Routing Problems&nbsp;({%- include taglink.liquid tag="CARP" -%}) as well as their versions with capacity limits, time limits, deadlines, penalties, peridocity, etc., are all hard.
- The Job Shop Scheduling Problem&nbsp;({%- include taglink.liquid tag="JSSP" -%}), Flow Shop Scheduling, and their variants are hard tasks which ask for optimal assignments of tasks to machines in a factory.

In summary, many questions that we encounter in management, design, engineering, planning, and logistics are hard optimization problems. And we need to solve them.

## How can we Solve Hard Problems?

### Example: Traveling Salesperson Problem
One of the most well-known hard combinatorial optimization problems is the Traveling Salesperson Problem&nbsp;({%- include taglink.liquid tag="TSP" -%}), which can be formulated as follows:

*Given is a set of $n$&nbsp;cities and the distances between each pair of two cities.
What is the shortest possible tour that visits all cities and returns back to its starting point?*

A candidate solution is a permutation of the $n$&nbsp;cities, i.e., a sequence which contains each city exactly once.
It describes the order in which the cities are to be visited and the way back is implied.

There are $|\mathbb{X}|=n!$&nbsp;many such permutations, which turns out to be quite a large number even for moderate&nbsp;$n$ as shown already in {% include image_link.liquid id="function_growth" -%}.
For example, $10!$&nbsp;is $3'628'800$ and $20!\approx 2.4\times 10^{18}$.
It turns out that we do not yet have an exact algorithm which can solve any possible TSP in $1.9999^n$ steps or less.
And chances are that we will never have one.

### Solving the Traveling Salesperson Problem
But what does it mean that we cannot guarantee to find the solution of a TSP in reasonable time?
First of all, the word "solution" is used here in a very strict and tight sense, in the sense of "exact" and "globally optimal":
A&nbsp;solution to the TSP in this classical sense is only the shortest possible round-trip tour through the $n$&nbsp;cities.

But what if we widen this definition a little bit:
Actually, every possible visiting sequence of the $n$&nbsp;cities which contains each city exactly once&nbsp;(and returns back to the first city) could be considered a solution.
We then simply have solutions of different quality, which we thus call candidate solution.

Even if we have a TSP with 10000&nbsp;cities, we actually can obtain one such solution very quickly.
We can write down all $n$&nbsp;cities directly in the same order as in the problem specification.
Or in random order.
Although there is a tiny chance that these might already be the exact best-possible solution to the TSP, they very, very likely will be a very very bad (candidate) solutions.
We thus have established one though:
We may not be able to guarantee to find the best possible solution for hard problems quickly, but we definitely can find some candidate solution.

### The Two Poles of Problem Solving
We now know the two polar opposites of problem solving:
On one hand -- for most problems -- we can find some random solution of poor quality quickly.
On the other hand, finding the best-possible solution may take far too long to be feasible.

Such a situation is not satisfying and if we face it, what we would want is something in between.

{% include image.liquid src="/assets/images/runtime_quality_tradeoff.svg" caption="A sketch of the time-quality trade-off we make with optimization on the example of random and optimal solutions for the Traveling Salesperson Problem." id="runtime_quality_tradeoff" %}

## Optimization: Getting Good Approximate Solutions in Reasonable Time
This "in between" is one of the things that metaheuristic optimization does.
On the left end of the scale in {% include image_link.liquid id="runtime_quality_tradeoff" -%}, we find the aforementioned random solutions which do not make use of any information from the problem.
But we usually have a lot of information:
In the TSP, for instance, we know the distances between the cities.

### Constructive Heuristics
Constructive heuristics are methods which usually create a single candidate solution in a meaningful, one-shot fashion by utilizing information from the problem.
Heuristics for the TSP, we could apply a nearest neighbor heuristic which creates a tour step-by-step by first picking a (random) city and then iteratively adding the city nearest to the previously added one to the tour.
This means we need something in the scale of $n^2/2$&nbsp;steps, as every time we want to add a city, we have to check all not-yet added cites.
It will normally produce much better solutions than creating random solutions, but usually also not find the best possible tour.

### Local Search
If we move up the time scale, we arrive at the family of {% include taglink.liquid tag="local_search" %} algorithms, which start with a single solution and try to iterative improve it.
Assume we have created a solution for the TSP using a heuristic.
We could now check whether we can swap two cities in the tour.
If this results in a better tour, we take it. If not, we try again.
Usually, there exist many different such refinement operators.
This algorithm is commonly called randomized local search&nbsp;({%- include taglink.liquid tag="RLS" -%}) or (1+1)&nbsp;EA.

In the TSP, besides swapping cities, we could reverse a leg of the tour or rotate the cities a leg to the left or right.

Also, there exist several ways for applying the moves in each step of the local search:
We could first try all $n(n-1)/2$&nbsp;city pairs that can be swapped and actually swap the one which improves the tour the most, if any.
Or we could try the swaps and pick the first improving swap.

A local search cannot guarantee that we find the optimal solution either.
We may arrive in a dead end, a local optimum.
If we use the two-city-swap operator, this could be a tour which cannot be improved by swapping two cities but needs a more complex change.

Thus, local search methods can be enhanced with a variety of additional measures, such as restarting if no improvement can be found&nbsp;(but, of course, remembering the best solution so far).
Examples for algorithms that do this are Simulated Annealing&nbsp;({%- include taglink.liquid tag="SA" -%}) and {% include taglink.liquid tag="tabu_search" -%}.

### Population-Based Metaheuristics and their Hybrids
In order to prevent running into local optima to quickly, the concept of population-based metaheuristics exists, mainly known under the labels Evolutionary Computation&nbsp;({%- include taglink.liquid tag="EC" -%}), Evolutionary Algorithms&nbsp;({%- include taglink.liquid tag="EAs" -%}), and Genetic Algorithms&nbsp;({%- include taglink.liquid tag="GAs" -%}).

Here, a set multiple of solutions in maintained and iteratively refined.
However, these algorithms are usually way to slow to be of practical use.
They are thus hybridized with local search:
The resulting Memetic Algorithms&nbsp;({%- include taglink.liquid tag="MAs" -%}) can guard against getting stuck too early while having the speed of local search.

### Exact Methods vs. Approximate Methods
Exact optimization algorithms naturally solve a problem to optimality, incurring the potential large, exponential runtime.
It should be noted, however, that the runtime is only exponential in the worst case, e.g., in TSPs with particularly nasty distributions of cities.
In many real problems, exact algorithms might be able to run in a reasonable time.
The Concorde TSP Solver has solved a TSP with 85900 cities to optimality, for example.

On the other hand, although metaheuristics and local search usually do not guarantee to find the optimal solution, they might actually do so, and they might do quite quickly.
The LKH&nbsp;algorithm is a local search which has also found the solution for the same 85900-city problem -- but probably much faster than Concorde.
To solve a 13'509 city-problem, Concorde needed three months on a cluster while LKH did the job in half a day on a desktop computer.
Of course, being a fancy local search, it cannot give any guarantee that the solution it found was optimal.
We only know this because of Concorde.

Thus, both exact and approximate methods have drawbacks and advantages.

## Everything is an Anytime Algorithm
Finally, it should be noted that most optimization methods are anytime algorithms.
These are algorithms that can be stopped and provide an approximate solution at any time.
This is easy to see for local search, for example:
Once it has an initial solution, we can always stop it and just take the best solution it found so far.
This is also true for all metaheuristics and, interestingly, also many exact methods.

Branch and bound&nbsp;({%- include taglink.liquid tag="bab" -%}) algorithms iteratively and recursively divide the search space into regions and only search those which may improve upon the best solution they have so far.
They repeat this until there is no such region left, which then means that the best-so-far solution is the best-possible solution.
But, of course, we can stop them earlier and just take the best-so-far solution&nbsp;(losing the guarantee to get the best-possible solution in the process.

From this perspective, most optimization algorithms become comparable, processes of the development of solution quality over time …but this is another post altogether.

## Formal Definition of Optimization Problem
So far, we have discussed roughly what an optimization problem is, a set&nbsp;$\mathbb{X}$ of possible solutions&nbsp;$x\in\mathbb{X}$ and a way to compare them.
Then we have explored different types of algorithms for solving such problems.
Let us now give a formal definition of optimization problems and some more examples.

### Single-Objective Optimization Problem
How can we compare solutions?
The most common way to do so is to define an objective function&nbsp;$f:\mathbb{X}\mapsto\mathbb{R}$, which assigns a real value to each candidate solution&nbsp;$x\in\mathbb{X}$.
$f$&nbsp;represents an optimization criterion, a quality or utility measure that we can understand.
We call this basic problem type a single-objective optimization problem.

#### Minimization
Often, $f$&nbsp;is something that we want to minimize, maybe a cost or the amount of other resources which would be required to realize the solution.
Then, candidate solution&nbsp;$x_1\in\mathbb{X}$ is better than solution&nbsp;$x_2\in\mathbb{X}$ if&nbsp;$f(x_1)&lt; f(x_2)$, worse if $f(x_1)&gt; f(x_2)$, and neither is better if&nbsp;$f(x_1)=f(x_2)$.

Our goal would be to find the one solution $x^{\star}\in\mathbb{X}$ with the smallest possible corresponding objective value&nbsp;$f(x^{\star})$.
Of course, there may be more than one such optimal solution.
Thus, we search for $x^{\star}\in$ with&nbsp;$f(x)\geq f(x^{\star})\forall x\in\mathbb{X}$.
If there is no other element&nbsp;$x\in\mathbb{X}$ with a smaller objective value than the one of&nbsp;$x^{\star}$, then&nbsp;$x^{\star}$ is optimal -- we cannot make a better choice.

#### Maximization
$f$&nbsp;could also be something that we want to maximize, maybe a profit that we could obtain when choosing the given solution or an accuracy, for instance.
In this case, we look for elements&nbsp;$x^{\star}\in\mathbb{X}$ with&nbsp;$f(x)\leq f(x^{\star})\forall x\in\mathbb{X}$ instead.
Minimization and maximization tasks are two sides of the same coin, as we can turn any maximization problem&nbsp;$f_{max}$ into a minimization task&nbsp;$f_{min}$ by setting&nbsp;$f_{min}(x)=-f_{max}(x)$.

#### Definitions under Minimization

Normally, I will assume that we are trying to minimize the objective functions.
In this case, we can have the following definitions:

**Definition&nbsp;1:**&nbsp;A single-objective optimization problem is a situation where we have multiple possible methods&nbsp;$x\in\mathbb{X}$ to reach a goal and want to choose the one that has the minimum cost&nbsp;$f(x)$.

**Definition&nbsp;2:**&nbsp;A single-objective optimization problem is where a space&nbsp;$\mathbb{X}$ of solutions&nbsp;$x\in\mathbb{X}$ is given and we want to find the element&nbsp;$x^{\star}\in\mathbb{X}$ for which a given function&nbsp;$f:\mathbb{X}\mapsto\mathbb{R}$ takes on the smallest possible value.

Of course, the goals defined in both definitions are rather strict and bring us back to the aforementioned problem:
There might not be any method that can find&nbsp;$x^{\star}$ in reasonable time.
Well, we just said that we *"want"* to find&nbsp;$x^{\star}$ &hellip; we might just not be able to.
We might have to accept a solution&nbsp;$x^{\times}$ with the smallest corresponding value&nbsp;$f(x^{\times})$ that we can discover with the time and resources we have available.

## More Examples
### Travel to Shanghai
Let's say I want to travel from my home in Hefei to Shanghai.
Obviously, there are several options to do so. Candidate solutions are, for example, solution&nbsp;$x_1$ could be a "hard seat ticket for slow train K462," $x_2$&nbsp;might be "second class seat in faster train D3016," $x_3$&nbsp;may be an "airplane ticket for flight MU5468 of the China Eastern Airlines," and so on.
The space of solutions is then&nbsp;$\mathbb{X}_A=\{x_1,x_2,x_3,\dots\}$.
As objective function&nbsp;$f_1$, I could choose the required travel time in hours.
It turns out that&nbsp;$f(x_1)\approx 5.4$, $f(x_2)\approx 3.4$, and&nbsp;$f(x_3)\approx 1.2$.
Amongst the three listed example choices, the airplane would be the best one -- under criterion&nbsp;$f_1$.

Since are only so-and-so many possible means of transportation available that I can use from my home in Hefei to Shanghai, the solution space&nbsp;$\mathbb{X}_A$ of this problem is finite and discrete.

The solution space&nbsp;$\mathbb{X}_A$ of this example has no clear structure and there are no direct relationships between the candidate solutions.
There may be classes of solutions&nbsp;(such as "slow trains") but that's about all what we can see at first glance.
Due to the lack of structure in the solution space, I would probably have to enumerate all possible solutions to find the optimum.

### Function Minimization
Another, this time purely artificial, optimization task is to find the minimum of a five-dimensional variant of [Ackley's function](https://www.sfu.ca/~ssurjano/ackley.html)&nbsp;$a(x):\mathbb{R}^5\mapsto\mathbb{R}$ with

$$f(x)=-a \exp{\left(-b \sqrt{\frac{1}{5} \sum_{i=1}^5 x_i^2 } \right)} -\exp{\left( \frac{1}{5} \sum_{i=1}^5 \cos{(cx_i)} \right)}+1+e$$

The space of possible solutions here is a subset of the five-dimensional Euclidean space&nbsp;$\mathbb{R}^5$, e.g.,&nbsp;$X_B=[-10,10]^5$.
A candidate solution would be a five-dimensional real vector.
If we want to find the minimum of&nbsp;$a(x)$, then we can simply use it as objective function directly, i.e., set&nbsp;$f(x)=a(x)$.

This time, we have uncountable infinitely many potential candidate solutions&nbsp;$x\in\mathbb{X}_B$.
This task thus is a so-called continuous or numerical optimization problem.
Interestingly, $\mathbb{X}_B$&nbsp;has a much clearer structure than the previous solution space:
I can take an existing solution&nbsp;$x_1\in\mathbb{X}_B$ and modify it a little bit, maybe by adding a vector of very small numbers, and get new, similar point&nbsp;$x_2\in\mathbb{X}_B$ as result.

If&nbsp;$x_2\approx x_1$, then probably also&nbsp;$f(x_2)\approx f(x_1)$.
This feature is called causality.
It is quite important for optimization and I will maybe talk about it at another time.
Furthermore, $f$&nbsp;is steady and symmetric.
If we have two reasonably similar solutions (vectors)&nbsp;$x_1$ and&nbsp;$x_2$, we can combine them in a meaningful way in order to get another solution&nbsp;$x_3$ which similar to both&nbsp;(and hopefully unites the different good characteristics of both) by setting&nbsp;$x_3=(x_1+x_2)/2$.
All of these properties may be useful when trying to minimize&nbsp;$f_2$ and may help us to find the solution&nbsp;(which happens to be&nbsp;$(0,0,0,0,0)^T$) in a finite amount of steps.

## Optimization: A Huge Area
I hope that these discussions and examples have shown that optimization tasks can come in many different forms.
Following the Law of the Instrument, virtually every task in mathematics and engineering, every question or decision in our daily life or work life can be considered as an optimization task.
The way in which we solve these tasks will largely depend on the structures of the solution spaces&nbsp;$\mathbb{X}$ and the objective functions&nbsp;$f$&nbsp;(as well as on the time and computing resources we have available).

### Objective Function Types
Some optimization tasks may have objective functions in a closed form, like Ackley's function.
The stability of the architecture for a new 40 floor office building during an earthquake, however, can hardly be expressed as formula.
For this task, as well as for many tasks from the engineering domain, the objective function may involve calling an external program running a randomized simulation.
We may even need to simulate several different scenarios for each candidate architecture.
Testing how good a given solution is may then take several minutes.
Obviously, an objective function of this type will hardly be steady or differentiable, but it may still exhibit causality.
It may still be able to solve it with the very same methods that we can use to find the minimum of Ackley's function.

### Multi-Objective Optimization
Although optimization tasks are most commonly defined with a single goal, this is not necessarily always the case. Multi-objective tasks have&nbsp;$m>1$, i.e., multiple, objective functions.
We can write them as vector function&nbsp;$f:\mathbb{X}\mapsto\mathbb{R}R^m$ with&nbsp;$f=(f_1,\dots,f_m)$.

When traveling from Hefei to Shanghai, I may not only be concerned with the travel time, but also with the travel cost. Hence, there are two conflicting goals:
Traveling by airplane is fastest, but will also be more expensive.
Then, finding candidate solutions representing suitable trade-offs between the different optimization criteria becomes our goal.

## Summary
As you can see, optimization can be everything and anything.
It is a really wide field, ranging from trivial problems over problems which we can solve with the right tools to tasks where we can only find approximate solutions in reasonable time.
How we solve these problems depends on the structure of the solution space&nbsp;$\mathbb{X}$ as well as the features of the objective function(s)&nbsp;$f$ as well as the algorithms that we are able to apply.
But this will be the topic of another time.

One of my [talks](/talks) is *"[An Introduction to Optimization](/talks/optimization.pdf)"*.
If you are interested in more information about this topic, you can check out these slides.
Our [moptipy](/moptipy) package offers implementations of several metaheuristic optimization algorithms in [Python](/programmingWithPython).
