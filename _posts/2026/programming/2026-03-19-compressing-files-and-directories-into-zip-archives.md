---
title: "Compressing Files and Directories into zip Archives"
date: 2026-03-19
last_modified_at: 2026-03-19
tags: ["linux", "bash"]
toc: false
---

In [this recent post]({%- post_url 2026-03-18-compressing-files-and-directories-into-tar-xz-archives -%}), I gave a small script for packing files and folders into [`tar`](https://www.gnu.org/software/tar).[`xz`](https://tukaani.org/xz) archives.
To the best of my knowledge, this offers the best compression ratio.
However, sadly, not everybody knows how to deal with `tar.xz` archives and there might be situations where we must provide data as `zip` archives.
These usually have a much worse compression ratio, but are fast to compress and uncompress and widely accepted.
I here present the small {% include taglink.liquid tag="linux" -%}/{% include taglink.liquid tag="bash" %} script [`zipCompress.sh`](https://thomasweise.github.io/scripts/linux/zipCompress.sh), which is drop-in compatible with [`xzCompress.sh`]({%- post_url 2026-03-18-compressing-files-and-directories-into-tar-xz-archives -%}) but instead produces `zip` archives.
It attempts to produce the strongest `zip` compression possible with the built-in tools.
You can download the script from [here](https://thomasweise.github.io/scripts/linux/zipCompress.sh).

If you want to compress a single file or folder named `X`, just invoke `zipCompress.sh "X"` and this will create the archive `X.zip`.
If you want to store multiple files or folders, say, `A`, `B`, and `C`, into an archive named `Y.zip`, then you would write `zipCompress.sh "Y" "A" "B" "C"`.

The resulting archives `Z.zip` can later be unpacked using `unzip Z.zip`.

{% highlight bash %}
{{download https://thomasweise.github.io/scripts/linux/zipCompress.sh}}
{% endhighlight %}
