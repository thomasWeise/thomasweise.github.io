---
title: "Converting Vector Graphics Formats"
date: 2026-03-23
last_modified_at: 2026-03-23
tags: ["linux", "bash"]
toc: false
---

Most graphics that we use in [publications](/research/publications) or reports are vector graphics, such as [SVGs](http://www.w3.org/TR/2011/REC-SVG11-20110816), [PDFs](https://pdf-lib.js.org/assets/with_large_page_count.pdf), sometimes also WMFs, EMFs, EPSs, or PS files.
It is often necessary to convert between them, most often between PDF and SVG.
This can be done via [Inkscape](https://github.com/inkscape).
Here I provide the little {% include taglink.liquid tag="bash" %} script [`vec2vec.sh`](https://thomasweise.github.io/scripts/linux/vec2vec.sh), which does this in the {% include taglink.liquid tag="linux" %} terminal.
It basically just executes Inkscape with the correct parameters.

All you have to do is to provide the path to the source vector graphics document and either the path to a destination document or the extension to convert.
If you call `vec2vec.sh mydoc.pdf svg`, then it will create a file `mydoc.svg`.
If you call `vec2vec.sh mydoc.svg svg ../result.wmf`, then it creates the document `result.wmf` in the parent folder of the current folder.
As output format, the script additionall supports [PNG](https://www.w3.org/TR/png-3), which is a raster graphic.
For the input format PDF, you can additionally specify the optional argument `flatten`, in which case all text is rendered as vector graphics, which may help in some cases where font issues mess up the output.

The script will check if Inkscape is installed and abort if not.
In that case, an appropriate error message is printed.
You can install GhostScript via `sudo apt-get install inkscape`.
The script will also fail with an error if either the input file does not exist or if the expected output file is not produced for some reason. 

[Here](https://thomasweise.github.io/scripts/linux/vec2vec.sh) you can download this script and the complete collection of my personal scripts is available [here](http://thomasweise.github.io/scripts/scripts.tar.xz).
In that collection, there also is a script [`convertTo.sh`](https://thomasweise.github.io/scripts/linux/convertTo.sh), which bundles different conversion scripts between different formats.
It decides based on the file extensions which scripts to use&nbsp;(or fails if no fitting script is available).
Another related script is [`office2pdf.sh`]({%- post_url 2026/programming/2026-03-20-converting-ms-office-documents-to-pdf -%}).

{% highlight bash %}
{{download https://thomasweise.github.io/scripts/linux/vec2vec.sh}}
{% endhighlight %}
