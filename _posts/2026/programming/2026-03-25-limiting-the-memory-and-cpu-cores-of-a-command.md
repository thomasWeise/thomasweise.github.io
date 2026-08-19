---
title: "Limiting the Memory and CPU Cores of a Command"
date: 2026-03-25
last_modified_at: 2026-03-25
tags: ["linux", "bash"]
toc: false
---

Sometimes we want to execute a command or program that may use too many CPU cores or too much memory and thus potentially crash our system.
Instead of waiting for this to happen, we can also limit the number of CPU cores as well as the memory that a process can use/allocate.
If the program can smoothly run within such limits, it will complete normally.
If it tries to allocate more memory than what we permit, it will most likely simply crash.
If we have *8*&nbsp;logical CPU cores, but we permit the program to only use&nbsp;*4*, then it can also never happen that the computer becomes too slow because of the computational load.
Regardless what happens, our computer will remain fully usable.

Here I provide the little {% include taglink.liquid tag="bash" %} script [`runWithLimits.sh`](https://thomasweise.github.io/scripts/linux/runWithLimits.sh), which does this in the {% include taglink.liquid tag="linux" %} terminal.
It takes as parameters

- The number of CPU cores that the command can use.
  If you specify 0, then as default we will use `max(1, (N-1)/2-1)` as default, where `N` is the number of available cores.
- The maximum permitted amount of memory that can be used.
  Valid units are `B`, `K`, `M`, `G`, `T`, standing for byte, kilobyte, megabyte, gigabyte, and terabyte, respectively.
- The command to execute and its arguments.

For example, `runWithLimits.sh 1 2M echo "Hello World!"` will run the program `echo` with parameter `Hello World!` on at most 1&nbsp;CPU core and permitting the program to use at most 2&nbsp;megabytes of memory.
This will normally work, but if you try `runWithLimits.sh 1 2B echo "Hello World!"`, it will likely crash, because 2 bytes of memory are not enough even for `echo`&hellip;

[Here](https://thomasweise.github.io/scripts/linux/runWithLimits.sh) you can download this script and the complete collection of my personal scripts is available [here](http://thomasweise.github.io/scripts/scripts.tar.xz).

{% highlight bash %}
{{download https://thomasweise.github.io/scripts/linux/runWithLimits.sh}}
{% endhighlight %}
