---
title: "Measuring the Runtime of (Optimization) Algorithms "
date: 2017-02-16
last_modified_at: 2026-02-27
tags: ["optimization", "metaheuristics", "local_search", "EAs", "TSP", "benchmarking", "ACO", "local_search"]
use_math: true
---
My research area is metaheuristic optimization, i.e., algorithms that can find good approximate solutions for computationally hard problems in feasible time.
The Traveling Salesperson Problem&nbsp;({%- include taglink.liquid tag="TSP" -%}) is an example for such an optimization task.
In a TSP, $n$&nbsp;cities and the distances between them are given and the goal is to find the shortest round-trip tour that goes through each city exactly once and then returns to its starting point.
The TSP is $\mathcal{NP}$-hard, meaning that any currently known algorithm for finding the exact / globally best solution for all possible TSP instances will need a time which grows exponentially with $n$&nbsp;on the worst case instances.
And this is unlikely to change.
In other words, if a TSP instance has $n$&nbsp;cities, then the worst-case runtime of any exact TSP solver is in&nbsp;${\mathcal{O}}(2^n)$.
Well, today we have algorithms that can exactly solve a wide range of problems with tens of thousands of nodes and approximate the solution of million-node problems with an error of less than one part per thousand.
This is pretty awesome, but the worst-case runtime to find the exact (optimal) solution is still exponential.

What researchers try to do is to develop algorithms that can find tours which are as short as possible and do so as fast as possible.
Here, let us look at the meaning of "fast."
Fast has something to do with time.
In other words, in order to know if an algorithm&nbsp;$A$ is fast, a common approach is to measure the time that it needs to find a solution of a given quality.
If that time is shorter than the time another algorithm&nbsp;$B$ needs, we can say that $A$&nbsp;is faster than&nbsp;$B$.
This sounds rather trivial, but if we take a closer look, it is actually not:
There are multiple ways to measure time, and each has distinctive advantages and disadvantages.

## CPU Time
Traditionally, we would measure the runtime of an algorithm as CPU time.
We could store the current system time of a computer in a variable&nbsp;$v$, run our algorithm&nbsp;$A$, and after the algorithm terminates&nbsp;(or finds a solution that has at least a specific goal quality), store the current system time in another variable&nbsp;$w$.
$C(A)=w-v$&nbsp;is then the time consumed by one run of&nbsp;$A$.

Most programming languages offer functions to access the current system time which can be used for performing such measurements.

Under Java, you may use `System.currentTimeMillis()`, which returns a time value in milliseconds, `System.nanoTime()`&nbsp;(since Java&nbsp;5) which returns a time value in nanoseconds, or the class `Instant` introduced in Java&nbsp;8.
Such a CPU time is quite a useful piece of information.
If you read literature about the TSP, many of them will report runtime as CPU time.
"How else?" you may ask, but wait until later in this post.
Anyway, CPU time is quite easy to understand.
It is a thing that exist in real physics and that intuitively makes sense to us.
However, there are some problems with it as well.

### Measurement Bias
First, we are not directly running an algorithm on an "abstract" computer.
We have implemented our algorithm in a programming language, we have compiled it, and then execute it under a given operating system and configuration.
Besides the process running our program, there are other processes.
If you use your normal work computer to run experiments, maybe you have an internet messenger open, a browser, or office program, or want to watch a video at the same time.
If your algorithm is implemented in Java and, hence, runs in a Java Virtual Machine&nbsp;(JVM), it will never be alone in that virtual machine.
There is at least a garbage collector&nbsp;(GC) thread that, from time to time, will perform some actions and consume runtime.
If you use `C` to implement your algorithm, you do not have a GC&nbsp;thread taking time, but you can never escape the overhead needed for memory management.
All of that would mess up your time measurements, since all processes and threads may share the same CPU.
You can close as many processes as possible, but not all.
There will always be some other processes, and these may do&nbsp;I/O or other stuff that could potentially slow down your process.

### Reducing the Bias
We could run the same process many times and take the minimum runtime.
The minimum runtime would be the best approximation, since the lower bound of the runtime of an algorithm implementation on a specific machine is the runtime of exactly and only the algorithm implementation.
Looking at this from the other side, we could say:
The only thing that can slow down an algorithm are system effects like other processes and stuff, and in the smallest measured time, their impact is the smallest amongst the measurements.

Of course, this idea only works for deterministic algorithms -- and metaheuristics are usually randomized, i.e., potentially take a different path of execution each time they are started.
Hence they also may consume a different amount of runtime every time they are executed and choosing the minimum runtime then may introduce another bias in your experiments.

Another way to measure the runtime of a process would be to use the actually consumed CPU time.
This time is usually offered by operating system tools and, combined with the above method, may give a reasonable approximation.
Under Java, you therefore could use the `management` API and `ThreadMXBean` to get the actual runtime of a given thread.
Profiling code to get approximate runtimes may be another viable approach, as one can expect that good profiling tools should take most of the issues discussed here into consideration.

### Unexpected Biases
Sometimes there can also be unexpected types of biases messing up our time measurements.
One possible source of problems is the measurement itself:
The system time is obtained from the operating system, by calling an operating system function.
This takes time too.

Another source of problems in Java is the&nbsp;JVM.
The JVM may perform code optimization and compilation to machine code after executing the code a couple of times.
So our program may first be executed in one way, and then in another.
And between these two ways, something else must happen, the just-in-time (JIT) compilation.
Thus, ideally, before measuring the performance of a piece of code, we should execute it a couple of thousands of times, to make sure that any potential JIT action has already taken place and will not interfere with the measurements.

If you do an experiment with an optimization method, you may want to create log files listing the progress of a method over time, i.e., storing multiple data points during a single run.
File I/O is still slower than RAM memory accesses.
Logging performance data to a file may thus mess up your entire measurement process.
Ideally, you should thus store all measurements in&nbsp;(a pre-allocated region of) memory and only write them to a file once the run has finished.

### Clock Precision and Resolution
In any case, we should also remember that both resolution and precision of the CPU time measurements are limited.
In the past, when I first did something with time measurements, you could get the current time on a PC in units of 1&nbsp;millisecond, but the clock precision was at about 10&nbsp;milliseconds.
The documentation of the method [`System.currentTimeMillis()`](https://docs.oracle.com/en/java/javase/25/docs/api/java.base/java/lang/System.html#currentTimeMillis()), in Java&nbsp;25 today still states:

<blockquote cite="https://docs.oracle.com/en/java/javase/25/docs/api/java.base/java/lang/System.html#currentTimeMillis()">
Returns the current time in milliseconds. Note that while the unit of time of the return value is a millisecond, the granularity of the value depends on the underlying operating system and may be larger. For example, many operating systems measure time in units of tens of milliseconds.

See the description of the class Date for a discussion of slight discrepancies that may arise between "computer time" and coordinated universal time (UTC).
</blockquote>

The [documentation](https://docs.oracle.com/en/java/javase/25/docs/api/java.base/java/lang/System.html#nanoTime()) of the aforementioned `System.nanoTime()` method states:

<blockquote cite="https://docs.oracle.com/en/java/javase/25/docs/api/java.base/java/lang/System.html#nanoTime()">
This method provides nanosecond precision, but not necessarily nanosecond resolution (that is, how frequently the value changes) -- no guarantees are made except that the resolution is at least as good as that of `currentTimeMillis()`. 
</blockquote>

and the same is true for the time values we can get via `ThreadMXBean`.

Generally, there is always some limit regarding how precise you can measure time.
It is usually higher than the resolution of the clock.
When evaluating your time measurements for a very fast algorithm, you might even get a consumed time of&nbsp;0.
If the algorithm runs too fast, we would therefore need to extrapolate its runtime by running it many times.
A common pitfall here is to run it, say, 10000&nbsp;times and divide the measured time by&nbsp;10000.

If the algorithm is too fast, we could still get a runtime of zero.
This is especially true when running programs that were built&nbsp;30 or so years ago on current hardware.
Instead, one could define a minimum time, say 10&nbsp;minutes.
The algorithm is run in a repeat-until style loop&nbsp;(that executes the body at least once) until 10&nbsp;minutes are elapsed.
Doing a floating point division of the actual time the loop took&nbsp;(it is likely to be slightly more than 10&nbsp;minutes if we always consider complete runs) by the amount of time the algorithm has been executed should yield a reasonable estimate in all but the weirdest cases.

### Window of Utility
Measuring CPU time has another severe limitation.
It strongly depends on the following features:

- Hardware Configuration: processor speed and type and number, RAM size and speed, mainboard, and any other hardware used.
- Software Configuration: operating system, used utility programs and 3rd party libraries.
- Implementation: Programming language (Assembler? C? Java? Python?), compiler (optimizations?), runtime environment (Java JVM version?).

If some elements in these configurations change, then the runtime measurements may change significantly too.
Matter of fact, this is the very reason for many developments in the above three fields, to make things faster.
This, however, also means that measured runtime has a very limited window of utility.
If you read a paper from 30 or so years ago, reporting the runtime of an algorithm on a Pentium&nbsp;II processor with 400&nbsp;MHz, then this information is not really useful for you, because you can hardly approximate the corresponding runtime on a machine today.

### What to Include?
Finally, when measuring CPU time, we need to be sure what we actually want to include into our measurements.
Let's say you want to benchmark an algorithm for solving a TSP instance.
Your implementation would load an instance from a file, find an approximate solution, and store it to another file.
Should we include the file I/O into our time measurement or not?
It depends on what you want.
If you want to know the overall, complete runtime of the program, or just the runtime of the algorithm solving the given instance.
In the latter case, including the file I/O in the measurement may make no much sense.
But what if your program does already some preprocessing while loading the problem instance?
Then this should be included.

### Summary
As a result, we can conclude that CPU time measurements are only useful if we very exactly document how they have been obtained and what exactly we have measured – and even then, they are useful only for as long as we can re-create the experiments, i.e., the used hard- and software platform is available.

Many researchers thus consider CPU time thus only as a very coarse approximation.
If one algorithm needs half the time than another one, they may consider them to be roughly in the same performance class.
Runtime measurements for single problem instances are then uninteresting, interesting is the comparison over several problem instances of different scales&nbsp;$n$: How does the runtime grow problem scale&nbsp;(remember ${\mathcal{O}}(2^n)$?)&hellip;

## Normalized CPU Time
OK, but what if we want to compare runtimes on single instances?
We cannot fix all of the issues that occur when measuring runtime, but we may try to mitigate at least the machine dependency a bit.
The idea is as follows: Before we measure the runtime of our algorithm&nbsp;$A$, we benchmark the machine&nbsp;$M$ on which we will run it and obtain a machine-dependent performance factor&nbsp;$Z(M)$.
We then use&nbsp;$Z(M)$ to normalize the runtimes&nbsp;$C(A)$ that we measure.

### Benchmark the Machine, then Benchmark the Algorithm
There are two ways to do that:
On one hand, you could run a standard benchmark for hardware, say LinPACK or something, telling you how fast your machine is in general.
However, such a measurement may not really fit to your experiment, because that hardware benchmark may measure features which are not relevant for your algorithm.

On the other hand, you could proceed as follows.
Say you want to measure the runtime of a TSP solver on a set&nbsp;$I=i_1, i_2, i_{\dots}$ of well-known instances&nbsp;$i_k$ of the&nbsp;TSP.
What you would like is that the machine-dependent performance factor&nbsp;$Z(M)$ reflects the performance of machine&nbsp;$M$ in terms of all features that are relevant for your algorithm&nbsp;$A$.
Since we can expect that most reasonable TSP solvers have similar requirements, it would make sense to pick a simple and easy-to-implement TSP solver&nbsp;$B$ and let&nbsp;$Z(M)$ be its runtime on machine&nbsp;$M$.

$B$&nbsp;should be deterministic and have a reasonable runtime, not too short&nbsp;(so measurements get imprecise) and not too long&nbsp;(as it would increase the time we need to experiment too much).
When measuring the runtime of&nbsp;$B$, the points discussed regarding reducing the measurement bias in the previous section should be considered.

### Apply Standardized Algorithm to Each Problem Instance
To get a perfect performance estimate, I suggest to not just apply&nbsp;$B$ on some TSP instance to get one value&nbsp;$Z(M)$.
Instead, I would apply&nbsp;$B$ to each instance&nbsp;$i_k$ in&nbsp;$I$ and get one performance factor&nbsp;$Z(M, i_k)$ for each of them.
The reason is that different problem instances may have different runtime and machine requirements.
A TSP instance with, say, 10&nbsp;cities may have a distance matrix that fully fits into the cache of a machine.
This may not true for an instance with 10'000&nbsp;cities, and for an instance with 1'000'000&nbsp;cities, not even a permutation representing one solution to the TSP may fit into the cache.
If we have one performance factor&nbsp;$Z(M, i_k)$ for each instance, created by runs of&nbsp;$B$ we can mitigate these influences as well.

If&nbsp;$Z(M, i_k)$ is the runtime of our standardized benchmark algorithm&nbsp;$B$, we can now divide all runtimes measured for the algorithm&nbsp;$A$ on instance&nbsp;$i_k$&nbsp;(that we are actually interested in) by&nbsp;$Z(M, i_k)$.
The result is a normalized runtime which should be reasonably comparable over a reasonable set of different machines.

### Pros and Cons
With this approach, we have somewhat mitigated the machine-dependency of CPU time.
However, we now have results that cannot be compared with results reported in literature, as these are generally not normalized.
Also, the normalized time has no unit and thus is less easy to interpret.
It also may still be biased by other processes running on the same machine messing up our measurements.

## Measuring "Algorithm Steps" 1: FEs
In the field of metaheuristic optimization, there exists another approach to measuring runtime:
to count the so-called objective "Function Evaluations," or FEs for short.

The basic idea here stems from black-box optimization.
Our optimization algorithm is supplied with a candidate solution data structure and an objective function&nbsp;$f$.
The objective function is the optimization criterion.
It takes a candidate solution&nbsp;$x$ as parameter and returns the objective value&nbsp;$y=f(x)$.
Here, $y$&nbsp;is a number rating the utility of&nbsp;$x$.
Usually, the smaller this number&nbsp;$y$ the better is the candidate solution&nbsp;$x$.

In case of the TSP, the candidate solution data structure could be "permutation of $n$&nbsp;cities" and $f$&nbsp;could return the length of the tour defined by such a permutation.
A black-box metaheuristic needs the candidate solution data structure along with a way to sample it and the objective function to find approximate solutions for a problem.

Often, computing the value of $f$&nbsp;will take a long time.
It could, for example, require us to perform complex simulations.
One could thus measure the runtime of an algorithm by counting how many times it evaluates the objective function&nbsp;(until it reaches a certain goal objective value).
This measurement is then entirely machine-independent.

Counting FEs can be used when benchmarking algorithms in a problem-independent way:
We could benchmark an algorithm by using a simple and fast-to-calculate objective function.
If this function has similar features that the complex real problem, then we can execute some experiments quite quickly.
The algorithm which needs the fewest objective function evaluations to attain the goal solution quality would then also be the fastest one when applied to the real problem.
The popular COCO / BBOB benchmarking system does exactly that.

We can summarize this idea of runtime measurement as follows:

- Identify the type of algorithm steps that seems to be the most computationally intense one and seems to have the highest contribution to the runtime in the algorithms that we want to compare.
- Count these steps and measure the runtime in terms of them.
- Ideally, you can replace them with a "dummy" operation that is much faster than the real one.
  Then you can do many more experiments in the same real time frame.
  In optimization, we therefore use simplified benchmark objective functions instead of real ones, which could, e.g., require complex simulations.

### Pros and Cons
This idea has several advantages.
Measuring algorithm runtime in terms of algorithm steps makes you entirely independent on the hardware, software, or programming environment.
Many papers in the domain of optimization report their result runtimes in terms of FEs, so there usually is a large stock of data available with which you can compare your results -- and these data will still be meaningful in 100&nbsp;years from now.

But there are also some drawbacks.
Counting FEs does not give us any tangible evidence how much runtime the algorithm will actually need.
This is clear, since FEs have no physical unit, i.e., are no time values to begin with.

Furthermore, FE-based time measures, by definition, do not include things such as start-up time, loading time, preprocessing, garbage collection or memory allocation, variable initialization, copying of arrays, lookups in a hash map, sorting of lists, updates of internal data structures, selection or reproduction in an evolutionary algorithm&nbsp;({%- include taglink.liquid tag="EAs" tag_text="EA" -%}), and so on.
All of these aspects are actually a part of the optimization algorithm, a part of the runtime it requires.
Let us say you implement an EA which performs truncation selection and therefore has to sort its population.
You will measure the same runtime in FEs, regardless of whether you use Quicksort or Bubble Sort for this purpose.
Is this good or bad?

All of these details are ignored under the assumption that the computation of the objective function is the most time consuming part of your algorithm, and everything else is negligible.
This is not always true, though.
In the TSP, for instance, it is not.

### Complexity of 1 FE
In the TSP, calculating the length of a completely new tour&nbsp;(candidate solution), visiting all $n$&nbsp;cities of a problem instance, requires exactly $n$&nbsp;distance calculation.
It can thus be done in&nbsp;${\mathcal{O}}(n)$.
Since we can expect that calculating the distance between two cities is reasonably fast, evaluating a new solution&nbsp;(maybe generated by a black-box metaheuristic) should be reasonably fast, too.

If this is true, we cannot a priori expect it to be the determining factor of the runtime of an algorithm.
Instead, we should think about the algorithm itself.
In the case of the TSP, we may ask "How much computational effort does it take to generate and evaluate a new solution over all?"
Let us stick with the permutation&nbsp;(path) representation for tours.
If we have an EA with some standard mutation and crossover operators, then generating a new tour will probably also take something in the range of&nbsp;${\mathcal{O}}(n)$ steps.
Maybe&nbsp;${\mathcal{O}}(n^2)$ for complicated crossover operators.
Let's stick with&nbsp;${\mathcal{O}}(n)$ for now.
In other words, creating and evaluating a new solution may happen together in ${\mathcal{O}}(n)$&nbsp;steps if we are lucky.
But is this also true for other TSP solvers?

It is not.
Let us look at Ant Colony Optimization&nbsp;({%- include taglink.liquid tag="ACO" -%}), another metaheuristic which has successfully been applied to the TSP.
In ACO, we simulate the way an ant walks from a source to a destination point.
If we implement this for the TSP, we could start by placing the simulated ant at some random origin node.
The ant needs now to choose which node to visit as second step in its tour.
For this purpose, it will check each edge incident to its current location and heuristically decides&nbsp;(based on the length of the edges and the amounts of simulated pheromones on them) which way to go.
It will repeat this procedure until it has visited all nodes.
This means it will make&nbsp;$(n-1)+(n-2)+(n-3)+\dots+2$ comparisons.
This is in&nbsp;${\mathcal{O}}(n^2)$.
In other words, one&nbsp;FE performed by ACO has significantly higher complexity than one&nbsp;FE in the EA.

But there is also the opposite case:
Let us assume we have already created a solution&nbsp;$x_1=(1 2 3 4 5 6 7 8 9 10)$ and we just want to swap two randomly chosen cities in the tour, say city&nbsp;$3$ and&nbsp;$8$.
We get tour&nbsp;$x_2=(1 2 8 4 5 6 7 3 9 10)$.
If we know the length&nbsp;$f(x_1)$ of the first tour&nbsp;$x_1$, then we can calculate the length of the new tour&nbsp;$x_2$ by subtracting and adding four distances:
We subtract the distance from nodes&nbsp;$3$ and&nbsp;$8$ to their predecessor and successor cities in&nbsp;$x_1$ and add their distances to their new predecessors and successors in&nbsp;$x_2$.
This means we can generate and evaluate a new solution under such a "swap" move in&nbsp;${\mathcal{O}}(1)$&nbsp;distance computations.
This happened because we are actually not doing black-box optimization but use knowledge about the structure of the objective function.

Nevertheless, from these examples we can see that the processes required for one&nbsp;FE may have significantly different costs depending on the optimization method applied. Comparing one FE under the "swap" move with one FE carried out by ACO seems to be unfair.
One can easily understand that there are no limits to how much complexity one can put into the process of generating a new candidate solution and performing a function evaluation.
Comparing FEs thus only makes sense if the algorithms have similar per-FE complexity, e.g., use the same search operators.

## Measuring "Algorithm Steps" 2: Fine Grained
Let us move from black-box optimization, where no knowledge about the problem and objective function structure is integrated into our algorithms, to problem-specific optimization, where such knowledge is used.
We may find that the process of building candidate solutions becomes determining factor for the overall runtime.
Just counting FEs may be unfair, although it also has quite a few advantages.
It seems logical to look for more fundamental algorithm steps that can be counted, in order to mitigate the disadvantages of counting FEs while preserving its merits.

In the TSP, for example, one candidate for such steps could be "distance evaluations."
In our previous example, we assumed that an EA could perform a crossover or off-the-shelf mutation operation in&nbsp;${\mathcal{O}}(n)$&nbsp;steps.
Calculating the length of a completely new tour requires us to perform exactly $n$&nbsp;distance calculations as well.
In ACO, the decision a simulated ant makes depends on the pheromone on an edge and the length of the edge, i.e., the distance.
The ant makes, in total, ${\mathcal{O}}(n^2)$&nbsp;such decisions.
And to calculate the tour length of a new tour, generated in&nbsp;${\mathcal{O}}(1)$&nbsp;steps by a swap operator, takes at most $8$&nbsp;distance calculations.

In other words, in these three examples, the number of city-to-city distances we need to compute during the creation of a new solution is in the same big-${\mathcal{O}}$ class as the fine-grained algorithm steps needed for this process.
Counting the distance evaluations&nbsp;("DEs") in a TSP thus seems to be a fairer time measure than counting&nbsp;FEs.
It may still not be entirely fair, since there might be operator implementation that can compute the new solution distance with a number of DEs which is in a different complexity class than the number of steps needed to generate the solution:
Reversing a sub-tour of length&nbsp;$1<m<n$ may be implemented in&nbsp;${\mathcal{O}}(m)$ steps while the new tour length is computed in&nbsp;${\mathcal{O}}(1)$&hellip;

Using DEs has some drawbacks.
First of all, it is still not related to real clock time, although we can expect a closer relationship.
Second, like FEs, it cannot capture any algorithm steps not related to distance calculations.
If our optimization algorithm performs a complex analysis of previous search steps by using Machine Learning approaches, or if the majority of the modifications that it applies to a candidate solution do not require calculating city distances, this will (still) go unnoticed.
Third, there exists no related work that uses such a time measure, so you will not find papers to compare your results with.
Finally, fourth, DEs are a TSP-specific time measure. For any optimization problem, one would have to define a suitable fine-grained algorithm step measure.
(In MaxSAT problems, one could count bit flips, for instance.)

If we just want to measure the black-box optimization capabilities of an optimization algorithm, we would stick to FEs, as we would simply assume that FEs take so long that nothing else matters.
If we compare TSP solvers, however, DEs may offer a fairer, machine-independent way to measure time.

## Summary
In this post I tried to gather some thoughts regarding how to measure the runtime of an (optimization) algorithm.
I ended up with four time measures, clock time, normalized time, FEs, and DEs&nbsp;(or that alike).
Each of them has some advantages and drawbacks.
For comparing runtimes, I would use all four measures.
Real clock time is already contained in the normalized time and normalized time seems to be the "more" machine-independent measure -- but having the actual clock time is still useful because it is a practical measure.
Both clock and normalized time can be influenced by the scheduling effects or the ability of the programmers to write good code.
FEs and DEs, however, are truly machine-independent.
However, they do not tell us anything about how much runtime an algorithm really consumes and are solely useful for comparison purposes.

In our {% include taglink.liquid tag="tspsuite" %} developed back in the 2010s, we implemented all four time measures. 
Experience showed us that algorithms often, but not always have similar behaviors in all time dimensions.
Sometimes, an algorithm might look faster in terms of FEs while it is actually not in real time.
I believe that getting the full picture is important, and measuring at least one real clock time dimension and at least one algorithm step dimension seems to be a small effort for a better understanding of algorithm behavior.

{::nomarkdown}{%- assign papers="WCLTTCMY2014BOAAOSFFTTSP" | split: "," -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}

Our current {% include taglink.liquid tag="moptipy" %} framework written in {%- include taglink.liquid tag="python" -%} is much more general and offers algorithm implementations that can be applied all possible sorts of problems.
We already applied it to the {% include taglink.liquid tag="TSP" -%}, {% include taglink.liquid tag="QAP" -%}, {% include taglink.liquid tag="packing" -%}, and {% include taglink.liquid tag="TTP" -%}, for example.
Here, we also collect the FEs and the clock time in log files.
Problem-specific time measures like normalized time and DEs are not available, because they, well, are problem specific and {% include taglink.liquid tag="moptipy" %} is a general tool.
