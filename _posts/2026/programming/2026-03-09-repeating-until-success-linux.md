---
title: "Repeating a Command until it Succeeds under Linux"
date: 2026-03-09
last_modified_at: 2026-03-20
tags: ["linux", "bash"]
toc: false
---

Assume that we have a command that we want to execute in a {% include taglink.liquid tag="linux" %} terminal.
We know that the command may sometimes fail, but it should actually succeed.
So we would try the command again and again until this happens.
An example is, for instance, a download process.
If we know that the URL is reachable, then the command should succeed.
However, maybe there is a lost connection or other temporary disturbance.
Another such command could be a build process which downloads and installs dependencies.

Here I post a small {% include taglink.liquid tag="bash" %} script that you may store as file [`tryForever.sh`](https://thomasweise.github.io/scripts/linux/tryForever.sh).
It will repeat a command until it succeeds.
It has two parameters:

1. The command to execute.
   This could be something like `"make"` or `"./buildMyProject.sh"` or even `"cat this.txt"`.
2. Optionally, you can specify a base path and name for log files to which the output of the command is piped.
   If no such base is provided, the command's output appears in the terminal just normally.
   If you provide something, say `"/tmp/log"`, then the stdout and stderr of the first attempt to run the command goes to `"/tmp/log1.txt"`, for the second attempt, it goes `"/tmp/log2.txt"`, and so on. 

Thus, you could try something like `tryForever.sh "wget https://thomasweise.github.io" "/tmp/log"` and it would try to download the website until it succeeds.
Obviously, this script will loop forever for commands that cannot succeed.
So it should only be used as a shortcut to not running the same program again and again by hand, while you are actually sitting in front of the terminal&hellip;
[Here](https://thomasweise.github.io/scripts/linux/tryForever.sh) you can download this script and the complete collection of my personal scripts is available [here](http://thomasweise.github.io/scripts/scripts.tar.xz).

{% highlight bash %}
{{download https://thomasweise.github.io/scripts/linux/tryForever.sh}}
{% endhighlight %}
