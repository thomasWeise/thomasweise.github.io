---
title: "Converting MS Office Documents to PDF"
date: 2026-03-20
last_modified_at: 2026-03-25
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

The script will check if LibreOffice is installed and abort if not.
In that case, an appropriate error message is printed.
You can install LibreOffice via `sudo apt-get install libreoffice`.
The script will also fail with an error if either the input file does not exist or if the expected output file is not produced for some reason.

[Here](https://thomasweise.github.io/scripts/linux/office2pdf.sh) you can download this script and the complete collection of my personal scripts is available [here](http://thomasweise.github.io/scripts/scripts.tar.xz).
In that collection, there also is a script [`convertTo.sh`](https://thomasweise.github.io/scripts/linux/convertTo.sh), which bundles different conversion scripts between different formats.
It decides based on the file extensions which scripts to use&nbsp;(or fails if no fitting script is available).
Another related script is [`office2pdf.sh`]({%- post_url 2026/programming/2026-03-23-converting-vector-graphics-formats -%}).

{% highlight bash %}
{{download https://thomasweise.github.io/scripts/linux/office2pdf.sh}}
{% endhighlight %}
