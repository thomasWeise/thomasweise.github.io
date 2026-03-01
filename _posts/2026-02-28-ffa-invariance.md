---
title: "Frequency Fitness Assignment and Invariance Properties"
date: 2026-02-28
last_modified_at: 2026-02-28
use_math: true
tags: ["FFA", "metaheuristics", "optimization"]
algorithms: ["RLS", "FRLS"]
---

Frequency Fitness Assignment&nbsp;({%- include taglink.liquid tag="FFA" -%}, {% include lang.liquid text="频率适应度分配" nowrap=true -%}) is an "algorithm plugin" that *fundamentally* changes how the selection step in {% include taglink.liquid tag="metaheuristics" %} works.
Recently, we discussed [how FFA can be plugged]({%- post_url 2026-02-23-plugging-ffa-into-metaheuristics -%}) into the simple {%- include taglink.liquid tag="local_search" -%} algorithm {%- include taglink.liquid tag="RLS" -%}, yielding the {%- include taglink.liquid tag="FRLS" -%}.
According to my claim above, the FRLS should work *fundamentally* different from the RLS.
That's a pretty bold claim.
Let me substantiate it a bit.

Before I do that, let me briefly illustrate the RLS as {% include algorithm_link.liquid id="RLS" -%} and the FRLS as {% include algorithm_link.liquid id="FRLS" -%}, though.

{::nomarkdown}{%- capture myalgo -%}
Sample solution&nbsp;$x_c$ uniformly at random from&nbsp;$\mathbb{X}$.
$y_c\gets f(x_c)$.
@[Until@] $\lnot$&nbsp;should terminate @[repeat@]
@1: $x_n\gets\mathit{Op1}(x_c)$; $y_n\gets f(x_n)$.
@1: @[If@] $y_n \leq y_c$ @[then@]
@2: $x_c\gets x_n$; $y_c\gets y_n$.
@[Return@] $x_c, y_c$.
{%- endcapture -%}
{%- include algorithm.liquid text=myalgo id="RLS" caption="The randomized local search&nbsp;(RLS)." -%}{:/}

The RLS starts by sampling an initial best-so-far solution&nbsp;$x_c$ randomly from the search space&nbsp;$\mathbb{X}%.
In each iteration, it applies the unary search operator&nbsp;$\mathit{Op1}(x_c)$ to it and obtains a modified copy&nbsp;$x_n$ of&nbsp;$x_c$.
If&nbsp;$x_n$ is not worse than&nbsp;$x_c$, then it is accepted and replaces&nbsp;$x_c$.
Otherwise, it is discarded.
This is repeated until the algorithm terminates. 

{::nomarkdown}{%- capture myalgo -%}
$H\gets (0, 0, \dots, 0)$.
Sample solution&nbsp;$x_c$ uniformly at random from&nbsp;$\mathbb{X}$.
$y_c\gets f(x_c)$.
$x_b\gets x_c$; $y_b\gets y_c$.
@[Until@] $\lnot$&nbsp;should terminate @[repeat@]
@1: $x_n\gets\mathit{Op1}(x_c)$; $y_n\gets f(x_n)$.
@1: $H[y_c]\gets H[y_c]+1$; $H[y_n]\gets H[y_n]+1$.
@1: @[If@] $H[y_n] \leq H[y_c]$ @[then@]
@2: $x_c\gets x_n$; $y_c\gets y_n$.
@2: @[If@] $y_n &lt; y_b$ @[then@]
@3: $x_b\gets x_n$; $y_b\gets y_n$.
@[Return@] $x_b, y_b$.
{%- endcapture -%}
{%- include algorithm.liquid text=myalgo id="FRLS" caption="The randomized local search with FFA, i.e., the FRLS algorithm." -%}{:/}

The FRLS works the same, but it replaces the selection decision.
Basically, here&nbsp;$x_n$ gets accepted if its objective value&nbsp;$y_n$ has not been encountered more often in selection decisions than the objective value&nbsp;$y_c$ of&nbsp;$x_c$.
This looks very strange.
Here I will not discuss why this is done.
All I will discuss is the resulting *invariance property*.

## Invariance under Injection Transformations of the Objective Function Value
**FFA makes algorithms invariant under all injective transformations of the objective function value.**
Let's say you are applying the FRLS to an objective function&nbsp;$f(x)$, where&nbsp;$x\in\mathbb{X}$ are the candidate solutions and&nbsp;$\mathbb{X}$&nbsp;is the search space.
The algorithm will begin with some random solutions&nbsp;$x_0$ and then iteratively sample a new solution&nbsp;$x_i$ in each iteration&nbsp;$i$.
Thus, it takes some path&nbsp;$x_0, x_1, x_2, x_3, \dots$ through the search space.
Actually, this holds for *all* metaheuristics, regardless how they sample and select solutions.
Each run of the algorithm could be viewed as a path traveled through the search space.

Now, if you replace&nbsp;$f(x)$ with a different objective function&nbsp;$g(x)$, then FRLS will take *exactly* the same path&nbsp;$x_0, x_1, x_2, x_3, \dots$ if an injective function&nbsp;$h$ exists such that&nbsp;$g(x)=h(f(x))\forall x\in\mathbb{X}$. 

## Invariance under Order-Preserving Transformations
The original algorithm RLS samples a new solution in each step and accepts it if it is not worse than the current solution.
This algorithm is also invariant under some mappings&nbsp;$h$, but these have to be order-preserving.
In other words, RLS will take the same path through the search space for two objective functions&nbsp;$f$ and&nbsp;$g$ if it holds that&nbsp;$f(x_a)\leq f(x_b) \Leftrightarrow g(x_a)\leq g(x_b)\forall x_a,x_b\in\mathbb{X}$.
This is a nice and strong invariance property.

But it is much weaker than the one offered by FRLS.
FRLS takes the same path through the search space for two objective functions&nbsp;$f$ and&nbsp;$g$ if it holds that&nbsp;$f(x_a)=f(x_b) \Leftrightarrow g(x_a)=g(x_b)\forall x_a,x_b\in\mathbb{X}$.
The only condition for this invariance property is that $g(x)=h(f(x))$ for an injective function&nbsp;$h$.
What does this mean?

Well, again, any order-preserving function&nbsp;$h$ is by default injective, so if RLS behaves the same on two problems, so does FRLS.
However, $h(\nu)=-\nu$ is *also* an injective function.
FRLS will follow the same path through the search space regardless whether optimize&nbsp;$f(x)$ or&nbsp;$g(x)=-f(x)$.

## Invariance under Permutation
FFA is only suitable for objective functions that are discrete, i.e., that can be mapped to the natural numbers&nbsp;$\mathbb{N}$.
Another injective mapping that can be applied to such functions are *permutations*.
Let's say that we have an objective function&nbsp;$f:\mathbb{X}\mapsto\{1,2,3,\dots,m\}$.
Then we could create *any* permutation&nbsp;$\Pi$ of the first&nbsp;$m$ natural numbers and optimize&nbsp;$\Pi[f(x)]$ instead.
And FRLS would still take the same path through the search space.

## Invariance under Encryption
Cryptography offers another form of injective mappings.
Normally, cryptographic algorithms&nbsp;$\mathcal{A}$ are applied to some form of text&nbsp;$T$ or binary data.
The algorithm usually receives&nbsp;$T$ as input together with some password&nbsp;$P$ and returns the encrypted data&nbsp;$C=\mathcal{A}(T,P)$.
$C$&nbsp;usually does not correlate with&nbsp;$T$ in any form.
Actually, this is the whole purpose of encryption.
Of course, encryption is bijective, i.e., knowing&nbsp;$P$ and&nbsp;$C$, you can reproduce&nbsp;$T$.
Bijective functions are a subclass of injective functions.

You could apply the FRLS to&nbsp;$\mathcal{A}(f(x), P)$ instead of&nbsp;$f(x)$.
And it would take the same path through the search space.

## Other Algorithms that are Invariant under Injective Mappings
How weird is that?
There are only three algorithms that have this strong invariance property:

- Random Sampling, i.e., in each step, create a completely random solution,
- Random Walks, i.e., create a new solution in each step and accept it regardless of its quality, and
- Exhaustive Enumeration, i.e., just test every possible solution, one after the other.

None of them are good optimization methods.
But algorithms using FFA can, in some domains, deliver better solutions than their original, objective-guided host algorithms.

Notice that, while we here explained this invariance property on the example of the FRLS, it will hold for *all* algorithms where the selection decision is guided purly by FFA.
You could plug it into an {% include taglink.liquid tag="EAs" tag_text="EA" %} or {% include taglink.liquid tag="MAs" tag_text="MA" %} or even {%- include taglink.liquid tag="SA" -%} &hellip; and they would become invariant under all injective transformations of the objective function value.

## Further Reading
{::nomarkdown}{%- assign papers="WWLCL2023FFAOWBFGSCBE,WWLC2021FFAMOAIUBTOTOFV" | split: "," -%}{%- include publications.liquid papers=papers shorter=true -%}{:/}
