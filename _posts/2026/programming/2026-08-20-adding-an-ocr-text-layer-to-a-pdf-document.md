---
title: "Adding an OCR Text Layer to a PDF Document"
date: 2026-08-20
last_modified_at: 2026-08-20
tags: ["linux", "bash"]
toc: false
---

Sometimes we have a PDF document which is entirely composed of images with text.
The text in these images cannot be selected or searched.
This is often the case if you have scanned documents and merged them into a PDF.
Also, quite often, we find some old research paper online as PDF, where the text looks more or less good and is rendered with fonts, but it can neither be selected nor searched, because the font shape and characters do not match.
What we want in both cases is to add an invisible layer of real text over the original PDF.
This text should then be search-, select-, and copy-able.
The script [`pdfAddOcrLayer.sh`](https://thomasweise.github.io/scripts/linux/pdfAddOcrLayer.sh) can create such a layer for you.

This can be done with a combination of [Tesseract](https://tesseractocr.org), [OCRmyPDF](https://github.com/ocrmypdf/OCRmyPDF), [Ghostscript](https://www.ghostscript.com), and [qpdf](https://github.com/qpdf/qpdf).
The idea is that we first take the original PDF document and convert it to a series of images and then apply optical character recognition&nbsp;(OCR) to these images.
Tesseract and OCRmyPDF can do this.
The result is a new PDF document&nbsp;`A` where everything from the original document is converted to an image and an invisible text layer is stacked on top.

This is already good for most cases, but it will render any previously existing text or vector graphics as image as well.
We therefore create a second new PDF document&nbsp;`B` from&nbsp;`A` where we delete all images and just keep the text.
We also create a third new PDF document&nbsp;`C` from the original document where all text is vectorized to vector graphics.
We then stack&nbsp;`B` on top of&nbsp;`C`.
This gives us a new PDF document which is visually the same as the source document, but where all the text is obtained via OCR.

This has the downside that all fonts are dropped from the PDF.
Basically, any originally existing text rendered via fonts now becomes geometrical/vector shapes.
This probably makes the PDF document bigger, but visually it looks the same.
On the top, we have an invisible layer of text that can be searched and copied.
So for a PDF with existing font-based text, we have separated the visuals from the text.
For a scanned document, this does not make any difference at all.
We have exactly the same visual impression of the scanned document, but we can now search, select, and copy text freely.

Here I provide the little {% include taglink.liquid tag="bash" %} script [`pdfAddOcrLayer.sh`](https://thomasweise.github.io/scripts/linux/pdfAddOcrLayer.sh), which wraps around Ghostscript and does this in the {% include taglink.liquid tag="linux" %} terminal.
It takes as parameters

- The path to the source PDF document.
- OPTIONAL: The path to the destination document&nbsp;(default: `_ocr` is added to the source name).
- OPTIONAL: The languages/scripts to be used&nbsp;(default: all languages/scripts available to Tesseract). 

[Here](https://thomasweise.github.io/scripts/linux/pdfAddOcrLayer.sh) you can download this script and the complete collection of my personal scripts is available [here](http://thomasweise.github.io/scripts/scripts.tar.xz).

{% highlight bash %}
{{download https://thomasweise.github.io/scripts/linux/pdfAddOcrLayer.sh}}
{% endhighlight %}
