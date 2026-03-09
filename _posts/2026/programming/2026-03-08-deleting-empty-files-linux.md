---
title: "Recursively Deleting Empty Files and Directories under Linux"
date: 2026-03-08
last_modified_at: 2026-03-08
tags: ["linux", "bash"]
toc: false
---

Sometimes, we have the need to delete empty files and empty directories under {% include taglink.liquid tag="linux" -%}.
This happens, for example, when we want to restart an experiment with {% include taglink.liquid tag="moptipy" %}.
Here I post a small {% include taglink.liquid tag="bash" %} script that you may store as file `deleteZeroSizedFiles.sh`.
It will do exactly that:
It will search the current directory and all subdirectories for empty files, i.e., files of size zero.
It will delete all of them.
Then, it will recursively look for empty directories, i.e., directories that do not contain files or other directories.
It will delete them as well.

{% highlight bash %}
#!/bin/bash

# Turn on strict error handling, so that the script fails as soon as something goes wrong.
set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   # set -u : exit the script if you try to use an uninitialized variable
set -o errexit   # set -e : exit the script if any statement returns a non-true return value

echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Deleting all empty files in current directory recursively."
find . -type f -empty -delete

echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Deleting all empty directories in current directory recurisvely."
find . -type d -empty -delete

echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Finished cleaning up."
{% endhighlight %}
