---
title: "Are Black-Box Global Search Methods, such as Metaheuristics like Evolutionary Algorithms, better than Local Search?"
date: 2017-01-26
last_modified_at: 2026-02-26
tags: ["optimization", "metaheuristics", "local_search", "EAs", "TSP"]
use_math: true
images: ["ea_ls_progress_tsp_kroa200"]
---
Sometimes, when discussing the benefits of Evolutionary Algorithms~({%- include taglink.liquid tag="EAs" -%}), their special variant Genetic Algorithms~({%- include taglink.liquid tag="GAs" -%}) with bit-string based search spaces, or other {% include taglink.liquid tag="metaheuristic" %} global search algorithms in general, statements like the following may be made:
{%- assign span_large_ps='<span style="color:red">' -%}
{%- assign span_large_budget='<span style="color:blue">' -%}
{%- assign span_diversity='<span style="color:green">' -%}
{%- assign span_outperform='<span style="color:DarkViolet">' -%}
{%- capture statement -%}
<em>"If you use a {{ span_large_ps -}}huge population size</span> with a {{ span_large_budget -}}large computational budget</span> for both global search metaheuristics~({{- span_diversity -}}with enough diversity</span>) and local search metaheuristics, the <strong>global search approach will no doubt
{{ span_outperform -}}outperform</span> the local search</strong>."</em>
{%- endcapture -%}
{{ statement }}
I cannot not really agree to this statement, in particular if it is applied to black box metaheuristics (those that make no use of the problem knowledge).

This post here is heavily related to the following paper:
{::nomarkdown}{%- assign papers="WWCTL2016GVLSTIOPSOEAP" | split: "," -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}

I will begin with a quick introduction to the concepts of local search, EAs, and black-box global search metaheuristics.
Then I will take apart the different assumptions in the statement above~(highlighted with different colors) step-by-step.
I make what I think is a good case against the assumption of superior performance of pure global optimization methods like EAs.
That being said, I conclude by pointing out practitioners rarely use pure EAs -- the best performing methods are hybrid algorithms that combine the speed of a local search with the resilience against getting stuck at local optima offered by global search. 

## Short Intro: Local and Global Search Metaheuristics
### Local Search
In optimization, a local search starts with generating one initial candidate solution.
In each iteration of its main loop, a local search algorithm will generate a new solution, which is usually a modified copy of the old one.
It then decides whether to keep the old solution and to dispose the new one or to drop the old solution and keep the new one for the next iteration.
The simplest variant of this scheme is randomized local search~({%- include taglink.liquid tag="RLS" -%}) which accepts the new solution if it is not worse than the current solution.
This idea has the problem that it can get trapped in a local optimum, i.e., a solution which has only worse neighbors~(other solutions that can be reached by applying one modification), but is not the best possible solutions.
The traditional hill climber is a slightly worse variant of this, as it only accepts solutions that are strictly better and thus even gets stuck if a solution is surrounded by equally good other solutions.

Simulated Annealing~({%- include taglink.liquid tag="SA" -%}) and~{%- include taglink.liquid tag="tabu_search" %} are other well-known variants that attempt to mitigate this problem.
They therefore additionally base their selection decision on the passed runtime/iteration count or search history, respectively.
Many specialized local search algorithms exist, which are tailored towards a specific type of problems.
An example is the Lin-Kernighan heuristic for the Traveling Salesperson Problem~({%- include taglink.liquid tag="TSP" -%}).

### Evolutionary Algorithms
Genetic or Evolutionary Algorithms follow another idea:
They maintain a population, a larger set, of $\mu$~solutions.
In each iteration, they create $\lambda$~new "offspring" solutions from these $\mu$~"parents" and out of these~$\lambda$ (or~$\mu+\lambda$, depending on the algorithm variant) individuals, select the next $\mu$~parents.
The hope is that this approach somewhat shields against the so-called premature convergence to local optima, if the population is sufficiently diverse.
It also allows us to perform a new form of search steps:
Recombination~(also called crossover) combines different~(hopefully good) solutions into new~(hopefully better) offspring solutions.

Similar concepts of sampling multiple solutions in each algorithm iteration occur in many metaheuristic global optimization methods like Estimation of Distribution Algorithms~({%- include taglink.liquid tag="EDAs" -%}) and Ant Colony Optimization~({%- include taglink.liquid tag="ACO" -%}).

### Black-Box Character
Many of the global optimization algorithms and local search methods are defined as black-box methods.
They only require a representation~(search space, search operators) and an objective function to work.
They do not need any deeper information about how a certain search move will influence the solution quality.
They also do not need to be able to systematically scan the neighborhood of a solution.
They will simply generate new candidate solutions from the current ones and keep the better with a certain probabilistic bias.

The considerations in the following text mainly focus on such kind of algorithms, because this is the "scenario" in which the initial statement is usually made.
And I want to criticize it in this framework.
Of course, it is easy to see that if we put more information into the design of an optimization method, we probably can get better results fast.
We will get to this as well.

## Problematic Issues

### Unlimited Population
So what is, in my opinion, wrong with {{ statement -}}?

Let us first imagine a {{ span_large_ps -}}huge, maybe unlimited population size</span> of a global search method.
Yes, let's say we have an EA with an infinite population size.
Of course, this EA will find the global optimum if its population is uniformly randomly initialized.
Every possible solution would be sampled at least once~(at least if we ignore the uncountably large size of theoretical continuous search spaces).
However, its performance will be exactly the same as the performance of a Random Sampling algorithm, which just keeps generating random solutions without any search logic at all.

#### Infinite Population = Random Sampling
Since the EA's population size is infinite, it would take an infinite amount of time to complete the first generation.
It would find the global optimum in that first generation.
Hence, at any elapsed finite amount of runtime, it would have only sampled random solutions -- i.e., behave indistinguishable from a random sampling process.

Good local search methods are likely to outperform random sampling, at least on the subset of the possible optimization problems for which they are suitable, that is.,
This is already implied by the No Free Lunch Theorem~(NFLT) and the confirmed by the fact that local search algorithms are actually used in practice.
This is especially true if we do not reduce the meaning of performance to the "runtime until the optimum is discovered," but also consider close approximations of the optimum.

#### Very Big Population = Random Sampling
Of course, infinite population sizes are an asymptotic, unrealistic assumption.
However, the time budget we have for optimization is usually limited.
A population large enough so that all runtime is consumed during the first generation is thus indistinguishable from an infinite population~(i.e., a random sampling process) in a practical scenario.
Even worse, an EA with such a population would be very unlikely to discover the global optimum:
It would basically perform random sampling for the available runtime and random sampling done for a practically feasible computational budget usually is one of the worst possible algorithms that rarely finds good solutions in all but trivial scenarios.

### Population Size 1 = Local Search
On the other end of the scale, at population size~1, the EA itself becomes a local search.
It can hardly be said to outperform local searches then.
Whether there always is a "sweet spot" in between these extremes at which it necessarily outperforms local search has, to the best of my knowledge, not yet been conclusively shown or otherwise theoretically proven, at least not on 
most practically relevant, hard problems.
Also this somehow smells like a violation of the NFLT to me.

## Infinite Runtime
Let us now imagine an EA with a finite population but granted {{ span_large_budget -}}infinite runtime/span>.
Assume that the search operations employed by the EA are complete, i.e., one mutation~(search step) can produce every possible solution from every possible solution~(just with different probabilities).
The EA will then also eventually find the global optimum.

### Infinite Runtime: May Still Converge to Local Optimum
Alas, there are well-known effects that can stop any pure EA from effectively analyzing the search space -- most prominently: premature convergence.
If the EA has prematurely converged~(which is possible) *and* its search operations are not complete, it may never find the global optimum.
If its operations are complete, its only chance to find the global optimum is through, let's say, a highly-random mutation step.

### Mutation Bias: May Make Matters Worse
However, mutation operators usually have a bias, making the production of "output solutions" which are more similar to their "input solutions" more likely than the production of completely different ones.
This makes a lot of sense.
Otherwise, without this bias, they would be the same as random sampling steps.
Since the overall probability sum is limited to~1, this bias could render the performance of an EA even worse than the performance of random sampling.

Random sampling creates each solution with the same probability, but in a prematurely converged EA, the creation of the globally optimal solution may have a smaller probability than the creation of a solution within the basin of attraction of the local optimum currently trapping the EA.
It could thus take much longer to find the optimum with that EA process than finding it with random sampling.

### Recombination: May Make Matters Worse
Different from the infinite population case, we here should also consider crossover~(also called recombination).
Crossover operations are usually not complete.
Their results usually contain parts of the parents.
In this case, these results cannot be completely arbitrary.
In a prematurely converged GA, the presence of crossover operators and the allocation of trials to them may make the situation even worse.

Of course, this premature convergence idea is a special case.
But we cannot rule it out.
Almost every search procedure will sooner or later converge.
If it converges, there are only two choices:
Either to a global optimum or not.
In the latter case, we have so-called premature convergence.

## Enough Diversity (But How?)
The statement "{{ span_diversity -}}with enough diversity</span>" is problematic as well.
Diversity can only be achieved by enforcing a certain amount of randomness instead of greedily selecting the best solutions.
Randomization can either be achieved in a uniform fashion~(and we arrive again asymptotically at random sampling) or in a biased fashion~(which could be even worse, as outlined in the previous example).

Maintaining diversity in the right way could make an EA better than any local search.
However, what is the right way?
What is enough diversity?
And how do we create it efficiently?
A "pure" $(\mu+\lambda)$~EA has no provision for that, and neither do other "pure" global optimization methods.

Maybe we can develop a specialized global optimization algorithm that fulfills the requirement.
First ideas in that direction are sharing and niching, but this is an active area of research.
Our Frequency Fitness Assignment~({%- include taglink.liquid tag="FFA" -%}) approach is one radical new take on this subject &hellip; but this is a story for another time. 

Anyway, even from the possibility that this goal may eventually be achieved for GAs, we may not be able to generalize to all metaheuristic global optimization methods.

## Performance Measuring
From my perspective, there are {{ span_outperform -}}two fallacies related to the definition of performance</span> in the idea that global search metaheuristics are better than local search ones.

### Finding the Optimum &hellip; but too Slow
The first problem is the assumption that an algorithm that finds the global optimum~(eventually) is better than one that does not.
If a local search can find a solution that is 0.000000000000001%~worse than the global optimum within 1~second but an EA finds the global optimum after 1000000000~years, does that make the EA better?

I think not.
Actually, if we had a lot of time, we would apply an exact optimization which can guarantee to find the optimum but potentially needs very long to do so.
None of the common metaheuristics can guarantee that.
The reason why we would use a metaheuristic like an EA or a local search is that we can live with an approximate solution~(which is not optimal), as long as we get it in reasonable time.

### Finding the Optimum &hellip; but Slower
The second fallacy is the idea that the ability of an algorithm to find the global optimum makes the algorithm good.
Random sampling will, too, find the global optimum eventually, if given enough time.
If finding the global optimum was indeed our criterion for whether an algorithm is good or not, we must show that it does so faster than both random sampling and an exact method.

This forces us to abandon assumptions about infinite populations and infinite runtimes.
It also forces us to limit the considerations to a specific problem class since otherwise, the NFLT would lead us to the conclusion that no optimization algorithm is good.

## But EAs may Still be Better!
### The Gist of Theoretical Studies Combined
In our paper mentioned initially, we also conducted a study of related work on population sizes in EAs, as several of the arguments above revolve around them.
Before, we briefly introduced the $(\mu+\lambda)$~EA, which maintains a set of $\mu$~solutions and uses them to sample $\lambda$~new solutions in each iteration.
A special case is $\mu=1$ and $\lambda=1$, i.e., the (1+1)~EA, which is a local search.
We found that several studies show that a (1+1)~EA may be able to outperform "true" EAs on some unimodal problems.
There are also several papers that confirm the existence of lower bounds for the required population sizes to render an EA efficient on other problems.

Together with the fact that a~$(1+\infty)$~EA equals random sampling, which likely is inefficient on most problems, this supports the assumption that there should be a "sweet spot" of population sizes at least for some problems in between:
a setting for $\mu$~and~$\lambda$ where the EA outperforms the local search.
Whether it exists for all problems and for the problem that you want to solve in particular is, however, an open question.

One issue with theoretical studies is that the problems one would normally use an EA for in practice are often $\mathcal{NP}$-hard, while the problems in most of the studies are rather simple~(because otherwise the Math gets quite ugly).
As a result, these studies consider the expected runtime to find the optimum, which one would intuitively expect to be exponential for $\mathcal{NP}$-hard problems such as the TSP.
When dealing with such problems, we are therefore interested in the~(functional) relationship between consumed runtime and approximation quality.
We did not find theoretical papers considering this~(but I am not a theory guy and our study was limited).

### Experimental Studies
In our study, we found several works experimentally discovering sweet spots for the population size in various optimization problems.
There is a consensus that small populations may lead to premature convergence, whereas large populations may waste computational resources.
Hardly any practitioner would argue against that.
However, many of the papers we found worked with small to moderate population sizes~(often below 1000), considered generations as time measure~(thus ignoring that generations required more computational effort with increasing population size), focused only on final results or whether the global optimum has been obtained~(whereas we should consider the improvement of approximation quality over runtime), or considered problems which are not $\mathcal{NP}$-hard.

{% include image.liquid src="/assets/images/ea_ls_progress_tsp_kroa200.svg" caption="The progress in terms of approximation quality over runtime~(measured in function evaluations~(FEs), log-scaled) for several algorithms~(EAs of different population sizes, hill climber and random walk with the same search operators, and specialized local search algorithms) on the Traveling Salesperson Problem~(TSP) benchmark instance KROA200 from the TSPLib." id="ea_ls_progress_tsp_kroa200" %}

In our own study in the paper cited initially, we applied EAs with several different population sizes to the {% include taglink.liquid tag="TSP" -%}.
We found that there is indeed a population size setting where the EA performs best~(for a certain computational budget).
(1+2)~EAs perform very similar to hill climbers~(with the same search operators).
EAs of larger population sizes behave very similar to random walks.
In {% include image_link.liquid id="ea_ls_progress_tsp_kroa200" -%}, this issue can be found illustrated on the benchmark instance `KROA200` from the well-known TSPLib benchmark set.
Here, EAs can beat both simple local search~(hill climber) and random walks using the same search operators on an $\mathcal{NP}$-hard problem in terms of approximation quality.
Yet, the specialized local search algorithm~(MNS) beats the pure EA at any time by a large margin.

## Hybrid (Memetic) Algorithms
From a practical perspectives, arguments about the performance of pure {% include taglink.liquid tag="EAs" %} are more or less uninteresting.
I think most practitioners will agree that pure EAs will not give us good performance, period.
What gives us best performance are hybrid algorithms, often also called Memetic Algorithms~({%- include taglink.liquid tag="MAs" -%}), which combine global and local search.
An example for this could be an EA which refines each newly created candidate solution with a local search before entering it into the population.
The population then mainly consists of local optima and recombination is used to combine their good traits.

Such algorithms have a remarkable success story and also, by far, are the best methods in my own studies on the TSP.
See, e.g.,

{::nomarkdown}{%- assign papers="WCLTTCMY2014BOAAOSFFTTSP" | split: "," -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}

Currently, the some of best known metaheuristics for the TSP, by Whitley et al. and Nagata et al., both use recombination and hybrid EAs with local search.

## Conclusions
From this discussion, I would conclude that we cannot assume that a metaheuristics for global optimization necessarily will outperform a local optimization algorithm, even if granted infinite runtime and/or an infinite population.
The fact that an EA can maintain a diverse population and is less likely to converge prematurely~(compared to a simple hill climber, at least) may not be that useful in practice, as we may have to pay for this with higher runtime requirements.

Black-box metaheuristics like pure EAs are blunt tools, heavy sledgehammers with which we can beat on problems that we do not understand well enough to design a clever algorithms.
They are also useful if  we need a quick prototype algorithm and have an EA lying around.
Often we will fare better with a local search, especially if we put some brains into it.
Once we get there, the last step is to combine this local search with an EA to reap the best of two worlds:
The EA's guard against premature convergence and the speed of the local search.

It should be mentioned that the above discussion does not necessarily hold for exact global optimization methods such as Branch and Bound~({%- include taglink.liquid tag="BaB" -%}) or Cutting Plane approaches.
These are designed differently and deserve their own, separate treatment.
