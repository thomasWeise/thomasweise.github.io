---
title: "Recursively Deleting Empty Files and Directories under Linux"
date: 2026-03-08
last_modified_at: 2026-03-17
tags: ["linux", "bash"]
toc: false
---

Sometimes, we have the need to delete empty files and empty directories under {% include taglink.liquid tag="linux" -%}.
This happens, for example, when we want to restart an experiment with {% include taglink.liquid tag="moptipy" %}.
Here I post a small {% include taglink.liquid tag="bash" %} script that you may store as file [`deleteZeroSizeFiles.sh`](https://thomasweise.github.io/scripts/linux/deleteZeroSizeFiles.sh).
It will do exactly that:
It will search the current directory and all subdirectories for empty files, i.e., files of size zero.
It will delete all of them.
Then, it will recursively look for empty directories, i.e., directories that do not contain files or other directories.
It will delete them as well.
All files and directories that get deleted are also printed, so you can see what happened.
[Here](https://thomasweise.github.io/scripts/linux/deleteZeroSizeFiles.sh) you can download this script.

{% highlight bash %}
{{download https://thomasweise.github.io/scripts/linux/deleteZeroSizeFiles.sh}}
{% endhighlight %}
