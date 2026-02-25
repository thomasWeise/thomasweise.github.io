---
title: "Why research in Computational Intelligence should be less nature-inspired."
date: 2016-12-31
last_modified_at: 2026-02-25
tags: ["CI", "EAs", "EC", "GAs", "ACO", "PSO", "SI", "metaheuristics"]
use_math: true
---

The inspiration gleaned from observing nature has led to several important advances in the field of optimization.
Still, it seems to me that a lot of work is mainly based on such inspiration alone.
This might divert attention away from practical and algorithmic concerns.
As a result, there is a growing number of specialized terminologies used in the field of Evolutionary Computation&nbsp;({%- include taglink.liquid tag="EC" -%}) and Swarm Intelligence&nbsp;({%- include taglink.liquid tag="SI" -%}), which I consider as a problem for clarity in research.
With this article, I would like to formulate my thoughts with the hope to contribute to a fruitful debate.

## Origin and Terminology
Before getting to the core, let me first exemplarily summarize&nbsp;(quickly and coarsely) the terminology and origin surrounding two algorithms, one from the area of EC and one from SI.
Like (almost) all metaheuristics, both are randomized algorithms.
They involve a certain amount of randomness in at least some of their decisions, which allows for two independent executions with the same input data to discover different solutions.

### Genetic and Evolutionary Algorithms
The field of EC more or less originated with research on Genetic Algorithms&nbsp;({%- include taglink.liquid tag="GAs" -%}).
GAs are usually referred to as metaheuristics that mimic the process of natural evolution in order to solve optimization problems.

In a GA, candidate solutions&nbsp;("phenotypes") are usually encoded as bit strings&nbsp;(`boolean[n]` in Java or C) of a fixed length&nbsp;$n$.
These encoded solutions are called "genotypes" or "chromosomes" in correspondence to the DNA in nature.
If the candidate solutions are something else than bit strings, a genotype-phenotype mapping&nbsp;(GPM) takes place, an injective binary relation from genotypes to phenotypes.
A tuple of genotype, corresponding phenotype, and often also the objective value, is often called an "individual."

A list of individuals&nbsp;(the population) is maintained and refined in an iterative procedure&nbsp;(where each iteration is called a generation).
The objective function, a function which relates a cost or profit to a candidate solution, is usually called fitness function and in this context usually is subject to maximization.
In the main loop of the algorithm, those strings that stand for candidate solutions of higher quality&nbsp;(with better objective values, i.e., higher fitness) are selected with a higher probability and those that represent bad solutions are&nbsp;(more likely) discarded.

The selected individuals enter the so-called mating pool and are allowed to produce offsprings.
These new solutions are derived by either creating modified copies of single strings&nbsp;("mutation") or by combining two strings to a new one&nbsp;("crossover", "recombination").
Both search operators are usually randomized.
This way, the list of solutions is filled again and the next iteration begins.
This process is repeated in a loop until, e.g., a time limit is reached or sufficiently good solutions are found.

We can replace the bit string genotypes with basically any genotype data structure in this algorithmic paradigm.
This generalized algorithm from is then called Evolutionary Algorithm&nbsp;({%- include taglink.liquid tag="EAs" tag_text="EA" -%}).

### Ant Colony Optimization
Ant Colony Optimization&nbsp;({%- include taglink.liquid tag="ACO" -%}) is one of the most well-known SI techniques.
It solves problems that can be mapped to finding paths in graphs with weighted edges by mimicking the path-finding behavior of ants.
Examples for such problems are Traveling Salesperson Problems&nbsp;({%- include taglink.liquid tag="TSP" tag_text="TSPs" -%}) and a variety of other {% include taglink.liquid tag="VRP" tag_text="Vehicle Routing Problems" -%}.

The problem solving is done by repetitively constructing paths&nbsp;(candidate solutions) by letting simulated ants walk through the graph.
An ant starts its journey at a given node and probabilistically decides which node to visit next.
This decision is influenced by two factors:
*(1)*&nbsp;the cost of going to the nodes, i.e., the weights of the edge from the current location to them, and
*(2)*&nbsp;the simulated pheromone on the edges to the node. The ant iteratively chooses where to go until its path is completed.
Several ants are simulated in each iteration of the algorithm.
The simulated pheromones are often maintained as floating point numbers in a matrix.
Usually the ants producing the best-rated paths in one iteration will update the pheromone matrix by increasing the pheromones along the edges they have traveled.
This, in turn, increases the probability that subsequent ants make similar decisions.
At the same time, existing pheromones are reduced by evaporation.
Then the process is repeated, new ants walk through the graph.

## Criticism
Two processes from nature have been successfully emulated as algorithms.
These algorithms turned out to be quite useful in solving hard optimization problems.
Although this itself is good, I believe that over the years, four problematic issues have arisen from this situation.

### Incompatible Terminology and Redundancy
Each "inspired" optimization method has its own terminology.
This makes it more complicated to discuss these methods without learning a lot of different vocabularies.
Moreover, different vocabularies often use different words for the same thing so there are quite a lot of synonyms.
A candidate solution in an EA called phenotype&nbsp;(or sometimes individual), in ACO it is called ant or path, in Particle Swarm Optimization&nbsp;({%- include taglink.liquid tag="PSO" -%}) it is called particle, some researchers even insist on calling it agent&nbsp;(and thus miss the point of any definition of that term&hellip;).

It seems that sometimes, the origins of optimization methods are valued over their algorithmic structures.
Then, instead of the abstract computer science perspective, it is the inspirational source that dictates the terminology.

This can cause confusion and inconsistencies.
In my opinion, for instance, an ACO basically is a special Estimation of Distribution Algorithm&nbsp;({%- include taglink.liquid tag="EDAs" tag_text="EDA"-%}).
An EDA is an optimization method that tries to build and update a probabilistic model of what good solutions look like.
In each iteration, it will sample this model to generate new candidate solutions.
The best generated candidate solutions will then be used to update the model.
A pheromone matrix as used in ACO could be considered as such a model.
The process of letting the ants find new paths guided by the pheromone matrix&nbsp;(the model) is nothing else than model sampling.
Pheromone evaporation and update then are the model update.
To the best of my knowledge, this similarity is not widely recognized or discussed -- and I believe that this is because of the "language barrier".

I would also argue that the language used in EDAs is clearer and more precise than the biological metaphor used in the field of ACO, without belittling the achievements of the ACO community.
A language focused on the statistical, mathematical, and theoretical features of an algorithm automatically invites researchers to test more complex stochastic concepts, e.g., more complex model building and sampling approaches, which are entirely unrelated to biological processes and not so easy to get to when starting from biological idea.

If ACO would indeed be a special form of EDAs, then having two distinct terminologies for essentially the same thing would potentially impose a problem for researchers when looking for related work.
If an improvement was discovered for ACOs, would it not be harder for researchers in the field of EDAs to see the relationship to their own work?
Some research might even be carried out in duplication.
In defense of the ACO terminology, I have to add that ACOs are older than EDAs and there probably exists more work on them, making a transition of terminology hard and unlikely to achieve&nbsp;(unfortunately).

There now are hundreds of different nature-inspired algorithms.
How many different vocabularies will this entail?
Whom amongst the readers has not yet reviewed a paper introducing a new nature-inspired algorithm together with a new vocabulary?
I fear that it may become quite hard to see whether a new idea is truly new or already exists in an algorithmically identical form under a name that cannot be inferred from the algorithmic properties&nbsp;(such as Snapping Turtle Herding algorithm; names are fictional and polemic, similarities with actual names are unintended and random).

### Dissonance between Terminology and Reality
I furthermore perceive a dissonance between the inspiration based on which an algorithm was created and its actual&nbsp;(feasible) working version, as well as between the vocabularies in EC and SI and their actual meaning.

Obviously, it is neither the goal of GAs to simulate evolution nor is it the goal of an ACO to actually simulate ant behavior or stigmergy in any realistic way.
Instead, the goal is to solve optimization problems.
This leads to the fact that any part of the simulation of the natural process will be abandoned if it is not useful for optimization or simply too complicate to implement.

A historical example for when the aim of modeling nature closely does not help in optimization is the original selection method used in GAs:&nbsp;Fitness Proportionate Selection.
Here, the expected number of offsprings of an individual is proportional to its fitness.
This sort of resembles the biological model idea of "fitness" in nature and natural selection.
Yet, it has several ugly drawbacks and thus may not always be a good idea.
The algorithm will produce entirely different results if, e.g., a constant offset is added to the fitness function, which does not change the nature of the optimization problem.
In many cases, Fitness Proportionate Selection is thus unsuitable and researchers often use a less nature-like to get better results.
Still, it is the historical method applied, it is in the books, it is what a novice will probably try first.

We can also look at this from a top-down perspective:
Natural evolution is generally considered to not have a target whereas GAs have a clear goal&nbsp;(minimization or maximization of the objective function).
The original GAs do neither simulate concepts such as geography, environment, population or social structure, age, time, nor bio-chemical, genetic, or molecular processes&nbsp;(although some of these aspects have, separately, been considered in later research).

In ACO, all ants execute an identical behavior, all ants are the same&nbsp;(no queens, workers, etc.).
Both ACO and GAs proceed in distinct iterations which solely depend on the state at the end of the previous iterations.
These diversions from the natural paragon are necessary in order to achieve good results&nbsp;(and to avoid making the algorithms too complex).

If we look closely, we will furthermore find that industrial-level and state-of-the-art EC methods do not only omit simulating phenomena from nature that are not useful, they even introduce algorithmic concepts that have no relationship to evolution at all. They do so because good results are not enough, excellent results are sought for – and because speed matters.

For several problems, the best EAs (those actually used in practical applications) are Memetic Algorithms (MAs), which incorporate local search methods. (The term meme serving as inspiration for MAs might be another example for unnecessary inspiration: the term hybrid instead would be much clearer.) Furthermore, often, data structures such as permutations, real vectors, or trees are used to represent candidate solutions, which cannot be understood as equivalents of DNA anymore. One of the best EC approaches for numerical problems is the Covariance Matrix Adaptation Evolution Strategy (CMA-ES). CMA-ES uses an approximated co-variance matrix to guide its search procedure and in many ways is similar to an EDA. In many EAs, sharing and niching penalize solutions in the population which are too similar to each other by changing their fitness in order to prevent an EA from converging to locally optimal solutions. EAs for multi-objective optimization use methods such as Pareto Ranking or hypervolume metrics which can hardly related to evolution. Several Evolution Strategy (ES) algorithms encode not only the candidate solutions themselves but also the step widths to be used to create new solutions from them inside the individual records, i.e., they store the scale of the mutation step-width inside the individual. ACOs are often modified to have minimum/maximum pheromone limits or "elitist ants" in order to achieve better results, pACO maintains a set of ants to define the pheromone. None of these things have obvious counterparts in nature.

This raises questions such as: Why should we describe an algorithm that has a list of λ permutations, selects the best μ of them as input for unary and binary search operations in order to generate the next λ permutations in a way any different than this? If there is a divergence between the original biological meaning of a word and its meaning in our algorithm description, is it good to use it? May it not rather confuse beginners who are new to the subject and may make it harder for them to understand why the algorithm actually works. Maybe it makes them even think that it is good to closely simulate nature to solve an optimization problem?

### Inspiration by Nature does not mean Good Optimization!
Inspiration from nature alone does not necessarily equal good optimization.
Why do we not encounter "pure" GAs, ACO, or PSO in practical applications or as winners of optimization competitions?
Because plain EAs or GAs can solve optimization problems to a certain degree, but often lose even to simple local search methods when compared to them thoroughly.
Yes, they can do global optimization and with the right setting and reasonably large populations.
They might sooner or later discover the globally optimal, best possible solutions.

Unfortunately, they are more likely to discover them later than sooner.
Plain EAs are not really good optimization algorithms.
It seems that in order to utilize their full power, they must be modified, hybridized, and extended with problem-specific knowledge.
EAs become fast if we combine them with a problem-specific local search, which can quickly find a local optimum&nbsp;(which the EA cannot do), while the EA
*1)*&nbsp;maintains a diverse population as buffer against premature convergence to, well, locally instead of globally optimal solutions and
*2)*&nbsp;a binary search operator to jump from two discovered local optima close to another, better one.
In other words, the natural inspiration only carries so-and-so far in optimization.

And this makes sense.
It is not the goal of natural evolution to produce perfect or even perfectly adapted species.
Evolution has no goal.
Species will survive if they are adapted sufficiently well, not necessarily perfectly well.

It is not the goal of the ants to find the perfect shortest path between a food resource and the nest.
A sufficiently short path discovered in reasonable time will do.
If we could use ants to discover optimal round-trip paths starting at their nest, passing over several food sources and returning back, i.e., solving {% include taglink.liquid tag="TSP" tag_text="TSPs" -%}, this would mean that biological processes could solve $\mathcl{NP}$-hard problems in sub-exponential runtime -- and although this would be awesome, it seems unlikely.

Indeed, ACO suffers from many problems when applied to optimization.
One is the that the pheromone matrix is quadratic in size&nbsp;$n$ in the number of cities, which makes maintaining and updating it quite costly for large&nbsp;$n$.

There is no reason to assume that being inspired by nature is enough to obtain better optimization methods than with purely mathematical approaches.
Thus, teaching the "inspired-by-nature" theme to many PhD students may pull research into a wrong direction.
Instead of focusing on the algorithmic and computer science perspective, much research energy may be spent in trying to develop algorithms inspired by baboons, squid, and the mating behavior of little crakes.
It is probably not a good idea to just simulate an arbitrary process in nature in order to obtain an optimization method.
This may actually hurt the EC and SI research community in the long term.

### It sounds unprofessional
And this hurting begins at the point where it makes research sound like quackery.
People in the industry are probably willing to apply algorithms that seem to be mathematically sound, rigorously researched, and professionally presented.
But even years of thorough research may become useless at the very moment a (previously) interested engineer sees "Squid Mating Algorithm" on the very first slide of a presentation.

## What can we do?
### Using Inspiration-Neutral Terminology
If a terminology has become folklore, it becomes very hard to go against it.
If publishing a paper at an EC-related conference, one has to use the corresponding vocabulary to some degree.
However, there are subtle changes to the wording that can help to improve clarity.
Some more general, formal terms can be used to describe our works.

Here I attempt to list some inspiration-neutral terms, most of which are actually quite common and frequently used.
Maybe these could be used more consciously and more often.

| Nature-Inspired Term        | Potential Alternative(s)                                            |
|-----------------------------|---------------------------------------------------------------------|
| Genome                      | Search Space                                                        |
| Genotype                    | Point in Search Space                                               |
| Phenome?                    | Solution Space                                                      |
| Phenotypes                  | Candidate Solution, Solution, Point in Solution Space               |
| Selection                   | Selection (term is inspiration-neutral)                             |
| Generation                  | Iteration                                                           |
| Creation of new genotype(?) | Nullary Search Operation                                            |
| Mutation                    | Unary Search Operator                                               |
| Crossover, Recombination    | Binary Search Operator                                              |
| Ant (in ACO)                | Depending on situation: Point in search space or candidate solution |
| Pheromone Matrix            | Model (à la EDA)                                                    |
| Genotype-Phenotype Mapping  | decoding                                                            |
| Individual                  | ?                                                                   |
| Population                  | ?                                                                   |
| Memetic Algorithm           | Hybrid Algorithm                                                    |
| Agent                       | only if it actually is an *agent*                                   |

For some terms such as population and individual, I have no good "inspiration-free" replacements yet -- I'd be happy about any input.

### Clear Teaching
I admit using the bio-inspired terminology in my own teaching as well.
One needs to make the connection to literature in one way or another and it just sounds cool for students.
However, GAs were never the first subject in my optimization-related courses.
They instead began by introducing the components of metaheuristic optimization in a way that is formal and as "inspiration-free" as possible.
And I used the above terms.

### Clear Algorithm Descriptions in Research
While we can change our own wording and notations to make our own work clearer, we may also influence others to do so as well.
There are two "access points" that come to mind:
When advising research students&nbsp;(research master students, PhD students, &hellip;) and when reviewing papers.

We can make clear that although inspiration may be drawn from whatever source, in the end, there must a formal algorithm, described in a clear and formal way.
This entails discouraging the use&nbsp;(and in particular, the invention) of specialized vocabulary.
Algorithms should be described short and precisely.
There should be meaningful pseudocode.

### Proper Benchmarking
As same as important as a clear description what an algorithm is doing is a clear assessment of its results and performance.
This means:

#### Benchmark Problems
Benchmarking is done on well-known instances of well-known benchmarking problems.
If a new algorithm is developed, results should be reported which are meaningful to a large share of the research community.
For example, most researchers may either already know what the Traveling Salesman Problem is or can find that out quickly.
They can search for "Traveling Salesman Problem Benchmark" and will immediately find TSPLib, a benchmark dataset with known optimal results&nbsp;*(as of 2026, the original website <http://comopt.ifi.uni-heidelberg.de/software/TSPLIB95> of TSPLib seems to be offline, but there are many other sites offering this dataset.)*.
If a new algorithm is applied to the TSPLib instances, it is extremely easy to get a quick impression on how good the results are and to find literature about the state-of-the-art or potentially related works.
If the new algorithm is applied to a problem from, say, laser optics, it will be significantly harder to judge whether it is good or not.

#### Fair Comparison
Good research requires fair comparisons with the best methods out there.
If a new algorithm is compared with a GA, then the GA should use the same search operators and be hybridized with the same local search&nbsp;(if any).
It should also be granted the same amount of objective function evaluations&nbsp;(FEs) and runtime:
If the new algorithms can do many FEs in the same real time interval, the GA should receive the same amount of FEs.
If the new algorithm needs more runtime per FE, the GA should receive the same amount of runtime&nbsp;(i.e., more FEs).
If the new algorithm is population-based, the GA should be tested both with the same population settings and with the best setup found for the&nbsp;GA.
If the setup of the new algorithm has been determined with a smaller preliminary experiment testing several configurations, then a similar experiment should also be carried out for the GA to find its best setup as well.
A new algorithm for the TSP representing solutions as permutations should not be compared with a GA using an unsuitable representation&nbsp;(say bit strings) for its solutions&nbsp;(and hence different search operators), because it would be entirely unfair.

### Worse or Negative Results
Of course, for most such well-known problems like the TSP, one will not be able to beat the state-of-the-art&nbsp;(SOTA), which was developed during years of research.
It is unlikely that any new algorithm can beat the SOTA.

We need to be clear, however, that we do not compare apples with oranges in a way that is unfair toward the new algorithm either.
For example, the SOTA on the TSP uses a lot of problem-specific information, including refined neighborhoods based on city distances and specialized datastructures and operators.
Comparing a black-box heuristic that simply works with permutations with that SOTA is entirely unfair.
Comparing a black-box heuristic with another black-box heuristic like randomized local search&nbsp;({%- include taglink.liquid tag="RLS" -%}) or a&nbsp;{%- include taglink.liquid tag="GAs" tag_text="GA" %} is fair.

Additionally, I believe, however, that even negative results are valuable too, if they were obtained with thorough experimentation with interesting new concepts.
Finding out why an algorithm did not work as well as expected can also be useful.
It may help to develop better methods.
If someone comes up with a similar idea, the knowledge that it already has been investigated and that it failed may save time and effort.
Accepting reasonably interesting negative results at conferences also creates more incentive for thorough experimentation.

## Further Reading
Excellent further reading on this topic are

- Kenneth Sörensen, Metaheuristics -- The Metaphor Exposed, *International Transactions in Operational Research* 22(1):3--18, January 2015. doi:[10.1111/itor.12001](http://doi.org/10.1111/itor.12001).
- Zbigniew Michalewicz, [The Emperor is Naked: Evolutionary Algorithms for Real-World Applications](http://cs.adelaide.edu.au/~zbyszek/Papers/essay1.pdf), *ACM Ubiquity,* November 2012, pages 1-13. doi:[10.1145/2390009.2399411](http://doi.org/10.1145/2390009.2399411).
