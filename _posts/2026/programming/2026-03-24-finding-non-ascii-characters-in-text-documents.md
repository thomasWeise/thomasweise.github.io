---
title: "Finding Non-ASCII Characters in Text Documents"
date: 2026-03-24
last_modified_at: 2026-03-24
tags: ["linux", "bash"]
toc: false
---

Sometimes we want to find whether a text documents contains only [ASCII](https://www.sensitiveresearch.com/Archive/CharCodeHist/Files/CODES%20standards%20documents%20ASCII%20Sean%20Leonard%20Oct%202015/ASCII%2068,%20X3.4-1967.pdf) characters or whether there is some non-ASCII character in it.
You see, ASCII is an old 7&nbsp;bit-based encoding for text.
Hence, it supports a very limited range of different characters and certainly not fancy stuff like "ä" let alone "你好".
Most tools today can understand the [Unicode](https://www.unicode.org) character set encoded with [UTF-8](https://www.ietf.org/rfc/rfc3629.txt), which is more or less compatible to that and can store all such characters.
Some software, however, still takes offense if characters appear that are outside the ASCII range, e.g., in names of functions in some programming languages.
Other software can deal with Unicode well, but dislikes only certain characters in certain places.
If we have some strange [LaTeX](https://www.latex-project.org) error when compiling a paper draft, sometimes it can help to check whether we accidentally had maybe a "。" instead of a "." slip in somewhere.

Here I provide the little {% include taglink.liquid tag="bash" %} script [`findNonASCIIchars.sh.sh`](https://thomasweise.github.io/scripts/linux/findNonASCIIchars.sh.sh), which does this in the {% include taglink.liquid tag="linux" %} terminal.
It takes the path to a file as argument.
It then searches the file for characters outside the ASCII range and prints where it found them.

[Here](https://thomasweise.github.io/scripts/linux/findNonASCIIchars.sh.sh) you can download this script and the complete collection of my personal scripts is available [here](http://thomasweise.github.io/scripts/scripts.tar.xz).

{% highlight bash %}
{{download https://thomasweise.github.io/scripts/linux/findNonASCIIchars.sh.sh}}
{% endhighlight %}
