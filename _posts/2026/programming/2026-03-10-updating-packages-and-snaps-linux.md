---
title: "Updating all Packages and Snaps"
date: 2026-03-10
last_modified_at: 2026-03-16
tags: ["linux", "bash"]
toc: false
---

I use {% include taglink.liquid tag="linux" %} for my work and try to keep my system up-to-date.
This means that, whenever I shut down my computer, I run a little Here I post a small {% include taglink.liquid tag="bash" %} script [`update.sh`](https://thomasweise.github.io/scripts/linux/update.sh) that updates all installed packages, both `deb` and `snap` packages.
Sometimes, for whatever reason, there may be a problem with some inconsistent package state.
My script basically applies all methods I know to fix such state.
The script is very heavy-handed and loops over the update process four times.
If for whatever reason one update would require another first and that could only be done by multiple updates, then that's no problem.
I usually run something like `sudo update.sh && shutdown now`, which then shuts down my computer.
So I do not really need to care how long the script needs anyway.
[Here](https://thomasweise.github.io/scripts/linux/update.sh) you can download this script.

{% highlight bash %}
{{download https://thomasweise.github.io/scripts/linux/update.sh}}
{% endhighlight %}
