---
title: "Why you should use Evolutionary Algorithms to solve your optimization problems (and why not)."
date: 2017-04-01
last_modified_at: 2026-02-28
tags: ["optimization", "metaheuristics", "EAs", "EC", "local_search", "RLS"]
use_math: true
---
[Some time ago]({%- post_url 2017-01-26-global-vs-local-search -%}), I discussed why global optimization with an Evolutionary Algorithm&nbsp;({% include taglink.liquid tag="EAs" tag_text="EA" %}) is not necessarily better than local search.
Actually, I was asked "Why should I use an EA?" quite a few times.
Thus, today, it is time to write down a few ideas about why and why not you may benefit from using an EA.
I tried to be objective, which is not entirely easy since I work in that domain.

## Why should I use an EA?
### Because in some fields they are the best.
Some of the most powerful approaches for solving a wide variety of problems are either variants of EAs or have resulted from EA research.
One example is the CMA-ES algorithm family for solving numerical optimization problems.
Another one, at least for a long time, was/is the NSGA-II for solving multi-objective tasks.
It should be noted, though, that these algorithms are more complicated than pure EAs.

### Because they are easy to implement.
EAs, used as black-box optimization methods, require little time from the specification of the data structure for candidate solutions&nbsp;(which must be done anyway) to a running algorithm providing reasonably good results.
By only providing six things, the basic cycle of an EA can be used to solve any particular problem:

- a nullary search operation to randomly create points in the search space for the initial population,
- a unary search operation (mutation) to create modified copies of existing points,
- a binary search operation&nbsp;(recombination, crossover) to combine existing points,
- a mapping from points in the search space to the solution space&nbsp;(decoding function, genotype-phenotype mapping, GPM), but usually both spaces are the same and this is the identity mapping,
- an objective function to rate candidate solutions, and
- a termination criterion telling the algorithm when to stop&nbsp;(e.g., after 1&nbsp;hour, after 10'000&nbsp;objective function evaluations, etc.).

The basic workings of the EA framework are independent of the actual implementation of these elements and a good open source implementation may be used for the EA.
Of course, the same operations are also enough to implement a randomized local search&nbsp;({% include taglink.liquid tag="RLS" %}), which is basically equivalent with a steady-state EA with one parent and one offspring.
If we try to use an EA to quickly prototype an optimization method, we thus can also directly compare it to the most primitive local search.
We thus can get an impression regarding the solution quality and structures we can expect.
This is also useful to check whether our algorithms actually produce the right kind of solutions, or whether there exist constraints we did not yet discover, for instance.

### Because sometimes, nothing else works.
Some optimization tasks may not have a precise mathematical formulation&nbsp;(e.g., if they involve complex simulations) and may be intangible with techniques such as linear programming.
It is, however, usually possible to define at least the above six things&nbsp;(otherwise you don't even have a proper problem specification) and an EA can work with that.
Whether the EA, in your specific case is better than say, a {% include taglink.liquid tag="local_search" %}, however, must be experimentally verified.
Most likely it will turn out that a combination of an EA and local search, a hybrid or memetic algorithm&nbsp;({% include taglink.liquid tag="MAs" tag_text="MA" %}), will work best.

### EAs can be parallelized and distributed.
EAs can be parallelized and distributed really well:
Since all the individuals in their populations are created and evaluated independently, the most time-consuming parts of handling a population of $n$&nbsp;individuals can be distributed to up to $n$&nbsp;processors or computers.
The time required by one iteration of an EA can thus be reduced to almost the same time required by one step of a local search method, while providing the power of global optimization.
This is particularly useful in cases where the objective function is costly to evaluate, e.g., where testing a candidate solution involves long-running simulations or computations.

### EAs are inherently suitable for multi-objective optimization.
To the best of my knowledge, Evolutionary Computation&nbsp;({% include taglink.liquid tag="EC" %}) techniques&nbsp;(and predominantly EAs) are the only optimization methods which are directly and inherently suitable to deal with multi-objective optimization tasks, i.e., tasks where we have to trade-off between multiple, conflicting optimization goals.
NSGA-II, an EA, is the most well-known approach to solve problems of this kind.
One of the strongest selling points here is not just that EAs can find good solutions, but they can even return a whole set of mutually non-dominating solutions from the Pareto frontier for the user to pick from.

### Robust optimization for dealing with noise and randomness.
For problems where the objective function is noisy or randomized&nbsp;(e.g., involves simulations), EAs provide a robust search for which little alternatives exist&nbsp;(again, to the best of my knowledge).
The same holds for problems which involve imprecision or insecurity, e.g., for planning {% include taglink.liquid tag="logistics" %} tasks for a company, where the actual traffic situation when executing the plan is not yet clear.

### Because free, open-source implementations are available.
Implementing EAs is quite easy or even trivial.
For the more sophisticated EAs, open-source implementations are usually available.
For the CMA-ES, the best numerical optimization method to my knowledge, you may find a large number of high-quality implementations for different programming languages and platforms, for instance.
This further shortens the time from problem definition to problem solution.
Our own {% include taglink.liquid tag="moptipy" %} framework offers the implementation of EAs and local search in {% include taglink.liquid tag="python" %}.

### Constructive vs. open processes.
Traditional engineering and planning can be considered as constructive processes in with limited spaces of possible solutions:
Rules guide the engineers and planners to build a solution to her task.
Only if she sticks to these rules, tools such as tables, rules-of-thumb, and handy equations are available.
EAs, on the other hand, can potentially discover any solution that fit to the data structures chosen in their implementation.
This can include solutions which are entirely different from what a human designer would have created.
This results from the fact that no particular solution features are predefined.
EAs as black-box methods only look for candidate solution that have very small objective values&nbsp;(if the objective function is minimized).
They are not a priori biased towards particular solution structures, unless such bias is introduced in form of problem-specific knowledge.
Solutions can emerge that are surprising and give us new insights.

### Hybrid Algorithms combining EAs with Local Search perform very well.
Although plain Evolutionary Algorithms often perform worse than local search methods, they provide a global optimization ability that may discover better solutions if given enough&nbsp;(a lot of!) time.
Integrating local search (or other algorithms like {% include taglink.liquid tag="bab" tag_text="branch and bound" %}) into EAs may combine both positive traits and is the aforementioned active area of research of hybrid or {% include taglink.liquid tag="MAs" tag_text="memetic algorithms" %}.

### The field matures and better tools emerge.
More and more sophisticated benchmarking approaches such as and our {% include taglink.liquid tag="tspsuite" %}, {% include taglink.liquid tag="optimizationbenchmarking" %}, and the modern {% include taglink.liquid tag="moptipy" %} framework allow us to get not only a deeper understanding of how randomized optimization methods work -- they also provide hard, state-of-the-art results.
The research on EAs becomes more and more mature.

### Because many researchers believe in them.
Since EAs are an extremely powerful and successful family of optimization methods, several journals with high reputation and impact factors are focused on them, including, e.g., the IEEE&nbsp;Transactions on Evolutionary Computation&nbsp;(TEVC).
This argument has a double value:
On one hand, it is good for researchers to publish in top-level journals.
On the other hand, it also shows that thousands of researchers and practitioners worldwide are convinced that EAs are a very useful concept, otherwise the TEVC would not have become a top-level journal.

### EAs have been successful in many fields.
Many practitioners and researchers have already applied EAs successfully in various real-world scenarios.

## Why should I not use an EA?
### Basic EAs are not useful for anything.
Off-the-shelf EAs like GAs that work on bit strings or textbook-style Evolution Strategies are either not suitable for solving realistic problems, which may have constraints or complex solution data structures, or do not provide solutions that are competitive with today's best approaches.

### EAs are very slow.
EAs are slow&nbsp;(runtime-wise) when run on a single computer.
Due to their population-based structure, each iteration requires creating and verifying many solutions plus there is some overhead in selection and fitness assignment procedures.
Also, if used as black-box methods, they make little use of problem-specific knowledge and thus converge much slower than local search algorithms tailored to a given problem.
In terms of function evaluations, pure EAs often need much longer to achieve the same solution quality as a local search.

### Global search does not necessarily beat local search.
EAs are global search algorithms and one argument for using them is "Given enough time, a global search will always give you better&nbsp;(or similarly good) results as a&nbsp;(specialized) local search method."
This argument is not necessarily true.
[Actually, it is often wrong]({%- post_url 2017-01-26-global-vs-local-search -%}).

### Many problems can better be solved with different optimization algorithms.
For many problems, we have tailor-made algorithms that perform quite well, better than a naive implementation of an EA could, anyway.
The Traveling Salesperson Problem&nbsp;({% include taglink.liquid tag="TSP" %}), one of the oldest and most well-known combinatorial problems poses an interesting example.
Here, local search methods based on the Lin-Kernighan Heuristic outperformed global search with EAs for a long time.
However, not too long ago, it turned out the EAs with specialized crossover operators can perform better than local search.
It took, however, many years of research to get there.

### Implementing an EA is easy, implementing a good EA is takes time.
The above example teaches us an interesting lesson:
Yes, it is easy to implement an EA.
But to get this beast to really provide us with excellent solutions, we must put problem-specific knowledge into it.
For doing this properly, experience and time are required.

### EAs have many parameters and are complex to configure.
Even basic EAs have quite a few parameters that need to be configured, such as population size, crossover rate, mutation rate, choice of selection algorithm.
Other parameters are implicit, like which unary and which binary operator to use.
Finding good settings requires quite some experiments, which, in turn, may take quite some time.
Expert users of EAs will be able to find good settings via rules-of-thumb and experience relatively fast, though.

### EAs are not always a good choice.
Do not use an EA if your problem does not fit to an EA.
EAs are useless for online problems where you have only a few seconds or milliseconds to find an answer.
Pure EAs are not suitable for large-scale problems with, say, 1000&nbsp;or more decision variables&nbsp;(with tricks you may make them feasible, but tricks are not easy for beginners).
If a problem can already be solved to optimality in acceptable time by an integer linear programming method, then using an approximative metaheuristic is useless.
Other problems are better solved with other techniques such as hybrid Ant Colony Optimization.

### EAs are just not suitable for some problem types.
Optimization problems may exhibit characteristics such as deceptiveness, ruggedness, epistasis, noise, and neutrality that make then hard for any metaheuristic optimization method&nbsp;(and EAs are one of those).
Such problems are generally hard.
Actually, they are the very reason why EAs were developed in the first place.
We need the power of populations to guard against premature convergence in rugged or deceptive search landscapes.
Yet, if the problem exhibits these features too strongly, the performance of the EAs also goes down and their advantages may diminish.
There exist methods to make EAs work under such conditions too, but it again requires quite some experience to pull something like this off.

### No theoretical results.
There are only very few tangible and generally applicable theoretical results regarding quality and runtime bounds for EAs.
Many theoretical results concern toy problems, hold only for the most basic EAs, or assume dodgy conditions such as infinite population sizes.
Since EAs are randomized, we cannot, in general, make statements about the solution quality they deliver or their required runtime.

### EA vocabulary sounds cool, but "cool" sounds unprofessional.
EAs have a nomenclature that kind of sounds unprofessional and voodoo.
Using terms like "genotype-phenotype mapping" or "phenotype" in front of an audience with little background on the EA concept may make you sound childish.
Practitioners with experience in domains such as linear programming may not take you seriously just because of your vocabulary.

### EAs have only a very small market share.
I think that in many areas of the industry, EAs are still either unknown or a niche technique.
People are reluctant to start new things, especially to try algorithms that cannot give any guarantee about the solution quality.
Well, in many scenarios, traditional methods cannot really guarantee this either and/or also cannot guarantee to find the optimal solution.
However, the threshold to convince decision makers is higher.
Also if you start an EA-based project and fail, the blaming assigned to you may be higher than when using traditional techniques that are known and accepted by colleagues and management&nbsp;(also see the above point).

### Available results do not generalize.
The problems used for benchmarking EAs&nbsp;(and any other optimization method) often are designed specifically for benchmarking and often do not stem from the real world.
Objective functions are usually fast to compute so that many experiments can be run.
Who knows whether the best methods according to benchmarks actually work well on your specific real-world problem.
As a result, it may be that algorithms are tuned for wrong problem features and the benchmarks do not match real-world requirements.
The No Free Lunch Theorem basically states that if we tune an optimization algorithm well to one kind of problem, its results will get worse for some other kinds of problems.

### Code is either not available or shoddy.
Documentation, style, reusability, and other basic rules of software development play no role during the programming part of a student's EA research.
Or in any other field in Artificial Intelligence or Machine Learning.
The software and program code corresponding to a scientific paper introducing a complex algorithm may sometimes not be available at all, and if available, it is often undocumented, incomprehensible, or otherwise useless.
This means that a programmer wanting to use a sophisticated EA may have to implement much code by herself and, in some cases, may find herself confronted with the need to codify complex mathematical concepts.

We try to do a better job with our {% include taglink.liquid tag="moptipy" %}) framework by providing rich documentation, many tests, and many examples.
Then again, this also means that there is a learning curve and time needs to be invested to actually learn how to use such tool.
Time is always scarce, too.

## Summary: My Personal Opinion
There are quite a few pros and cons for EAs.
I, personally, would say:
EAs are definitely good tools to quickly develop a prototype optimization method to solve a problem.
This can give you some baseline results and a significant insight into the problem structure.
Especially if you are developing a solution for an industry partner, quickly obtaining a small prototype piece of software can be helpful.
This allows you and your partner to verify whether the problem is defined correctly and whether some constraints are missing.

Then again, I would always first use a {% include taglink.liquid tag="local_search" %} like {% include taglink.liquid tag="RLS" %} and then test if I can get farther with an EA.
Of course, when we have the EA and the RLS, we can just as well test Simulated Annealing&nbsp;({% include taglink.liquid tag="SA" %}), too, because that's just two lines of code away from the RLS&hellip;
If the EA wins the comparison, take it.
Otherwise&nbsp;(the more likely case), it may be interesting to see whether hybridizing an EA with the winning algorithm can provide any advantage over that algorithm, which is actually quite likely.
If it happens, take that new method. If not, then this means that you still have solved the optimization problem, just using another method.
