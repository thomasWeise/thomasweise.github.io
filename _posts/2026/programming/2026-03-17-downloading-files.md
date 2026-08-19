---
title: "Downloading a File via a Script"
date: 2026-03-17
last_modified_at: 2026-03-20
tags: ["linux", "bash"]
toc: false
---

Sometimes, we want to download a file via the terminal {% include taglink.liquid tag="linux" -%}.
Downloading files may always fail due to connection issues.
So we want a command that tries again and again until success. 
Here I post a small {% include taglink.liquid tag="bash" %} script does exactly that, which you may store as [`download.sh`](https://thomasweise.github.io/scripts/linux/download.sh).
The script takes one or multiple URLs as parameter and downloads the corresponding files.
You could, for example, type `download.sh "https://thomasweise.github.io/programmingWithPython/programmingWithPython.pdf"` and it will download our book on the {% include taglink.liquid tag="python" %} programming language while `download.sh "http://thomasweise.github.io/scripts/scripts.tar.xz"` downloads my personal script collection.
The script uses [wget](https://www.gnu.org/software/wget) internally, but adds an infinite loop around it.
It also first tries 10 times to download the file without rate limitation and afterwards limits the connect speed in follow-up attempts.
If the URL is simply invalid or the file does not exist, the script loops forever.
[Here](https://thomasweise.github.io/scripts/linux/download.sh) you can download this script and the complete collection of my personal scripts is available [here](http://thomasweise.github.io/scripts/scripts.tar.xz).

{% highlight bash %}
{{download https://thomasweise.github.io/scripts/linux/download.sh}}
{% endhighlight %}
