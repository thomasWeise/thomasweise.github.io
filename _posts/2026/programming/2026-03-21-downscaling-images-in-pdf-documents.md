---
title: "(Down)scaling Images in PDF Documents"
date: 2026-03-21
last_modified_at: 2026-03-21
tags: ["linux", "bash"]
toc: false
---

Sometimes we have PDF document and want to submit through a web form, but it is too big.
Often, this size is caused by the images inside the PDF.
We may reduce their resolution, their "dots per inch"&nbsp;(DPI) value, and then the PDF gets smaller.
This can be done via [Ghostscript](https://www.ghostscript.com).
Here I provide the little {% include taglink.liquid tag="bash" %} script [`scalePdf.sh`](https://thomasweise.github.io/scripts/linux/scalePdf.sh), which does this in the {% include taglink.liquid tag="linux" %} terminal.
It basically just executes Ghostscript with the correct parameters.

All you have to do is to provide the path to the source PDF document and the DPI to which you want to scale it.
If you call `scalePdf.sh mydoc.pdf 200`, then it will create a file `mydoc_200dpi.pdf`, which is the same document, but scaled to 200&nbsp;DPI.
Additionally, you can also provide a destination path as optional third argument.
Invoking `scalePdf.sh mydoc.pdf 33 ../result.pdf` creates the document `result.pdf` in the parent folder of the current folder.
This new document would be the same as `mydoc.pdf`, but with all images inside scaled to 33&nbsp;DPI.
You can play around with different resolutions&nbsp;(DPI values) until you reach an acceptable file size.

If Ghostscript is not yet installed, the script will automatically install it.
[Here](https://thomasweise.github.io/scripts/linux/scalePdf.sh) you can download this script and the complete collection of my personal scripts is available [here](http://thomasweise.github.io/scripts/scripts.tar.xz).

{% highlight bash %}
{{download https://thomasweise.github.io/scripts/linux/scalePdf.sh}}
{% endhighlight %}
