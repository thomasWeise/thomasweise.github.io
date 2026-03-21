---
title: "Converting MS Office Documents to PDF"
date: 2026-03-20
last_modified_at: 2026-03-21
tags: ["linux", "bash"]
toc: false
---

Sometimes you have a Microsoft Office document, say an MS Word or MS PowerPoint file, and want to convert it to PDF.
If you do not have Microsoft Office installed, then you can do this via [LibreOffice](https://www.libreoffice.org), which is free open source.
Here I provide the little {% include taglink.liquid tag="bash" %} script [`office2pdf.sh`](https://thomasweise.github.io/scripts/linux/office2pdf.sh), which does this in the {% include taglink.liquid tag="linux" %} terminal.
It basically just executes LibreOffice with the correct parameters.

All you have to do is to provide the path to the office document as parameter to the script.
It will then create a PDF with the same base name in the current folder, e.g., `office2pdf.sh mydoc.docx` creates the file `mydoc.pdf` in the current folder.
This should work with extensions such as `.doc`, `.docx`, `.ppt`, `.pptx`, `.xls`, and `.xlsx`.
Additionally, you can also provide a destination path as optional second argument.
`office2pdf.sh mydoc.docx ../result.pdf` creates the document `result.pdf` in the parent folder of the current folder. 

If LibreOffice is not yet installed, the script will automatically install it.
[Here](https://thomasweise.github.io/scripts/linux/office2pdf.sh) you can download this script and the complete collection of my personal scripts is available [here](http://thomasweise.github.io/scripts/scripts.tar.xz).

{% highlight bash %}
{{download https://thomasweise.github.io/scripts/linux/office2pdf.sh}}
{% endhighlight %}
