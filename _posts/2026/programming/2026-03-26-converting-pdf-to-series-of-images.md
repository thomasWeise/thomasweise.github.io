---
title: "Converting a PDF Document to a Series of Images"
date: 2026-03-26
last_modified_at: 2026-03-26
tags: ["linux", "bash"]
toc: false
---

Sometimes we have a PDF document but want to convert it to a series of JPG or PNG images page-by-page.
This can be done via [Ghostscript](https://www.ghostscript.com).
Here I provide the little {% include taglink.liquid tag="bash" %} script [`pdf2imgs.sh`](https://thomasweise.github.io/scripts/linux/pdf2imgs.sh), which wraps around Ghostscript and does this in the {% include taglink.liquid tag="linux" %} terminal.
It takes as parameters

- The path to the source PDF document.
- OPTIONAL: The resolution for the output images in DPI, default is 300&nbsp;DPI
- OPTIONAL: The output image type, which must be either `jpg` or `png`, where `jpg` is the default.
- OPTIONAL: The destination folder.
  The default is a subfolder with the name of the original document with `-images` attached, in the current folder. 

For example, `pdf2imgs.sh myDoc.pdf` will create a folder named `myDoc-images` inside the current folder.
It will create JPG images with the names `myDoc-00001.jpg`,  `myDoc-00002.jpg`, &hellip; inside this folder, one of each page of `myDoc.pdf`, and each with the resolution of 300&nbsp;DPI.
`pdf2imgs.sh otherDoc.pdf 128 png X`, on the other hand, creates the folder `X` inside the current folder and places PNG images with the names `otherDoc-00001.png`, `otherDoc-00002.png`, and so on into it.
Again, each image holds one page of `otherDoc.pdf` and having a resolution of 128&nbsp;dots per inch.

[Here](https://thomasweise.github.io/scripts/linux/pdf2imgs.sh) you can download this script and the complete collection of my personal scripts is available [here](http://thomasweise.github.io/scripts/scripts.tar.xz).

{% highlight bash %}
{{download https://thomasweise.github.io/scripts/linux/pdf2imgs.sh}}
{% endhighlight %}
