---
title: "Compressing Files and Directories into tar.xz Archives"
date: 2026-03-18
last_modified_at: 2026-03-23
tags: ["linux", "bash"]
toc: false
---

Often, I want to compress one or multiple files or directories into an archive.
Maybe I want to upload experimental results to [zenodo](https://doi.org/10.5281/zenodo.5567725) or exchange them with my students.
Maybe I want to offer a package with [slides](https://github.com/thomasWeise/programmingWithPython/releases/download/2026.03.04/programmingWithPython_2026_03_04.tar.xz) of one of my classes.
Then I always use [`tar`](https://www.gnu.org/software/tar).[`xz`](https://tukaani.org/xz) archives.
They take a longer time to create, but the compression is usually best, often much better than what `zip` archives can produce.

Here you can find the {% include taglink.liquid tag="linux" -%}/{% include taglink.liquid tag="bash" %} script [`xzCompress.sh`](https://thomasweise.github.io/scripts/linux/xzCompress.sh) that can compress one or multiple files or directories into such an archive.
You can download the script from [here](https://thomasweise.github.io/scripts/linux/xzCompress.sh) and the complete collection of my personal scripts is available [here](http://thomasweise.github.io/scripts/scripts.tar.xz).
A similar and drop-in compatible script for producing `zip` archives is discussed [here]({%- post_url 2026/programming/2026-03-19-compressing-files-and-directories-into-zip-archives -%}).

Using it is fairly simple:
If you want to compress a single file or folder named `X`, just invoke `xzCompress.sh "X"` and this will create the archive `X.tar.xz`.
If you want to store multiple files or folders, say, `A`, `B`, and `C`, into an archive named `Y.tar.xz`, then you would write `xzCompress.sh "Y" "A" "B" "C"`.

The script will try to use a reasonable number of CPU cores, trying to strike a balance between speed and keeping the computer well usable during compression.
Still, if you have lots of data, the compression can take quite some time.
But usually it is well worth it.

The resulting archives `Z.tar.xz` can later be unpacked using `tar -xf Z.tar.xz`.

{% highlight bash %}
{{download https://thomasweise.github.io/scripts/linux/xzCompress.sh}}
{% endhighlight %}
