#!/bin/bash -

# strict error handling
set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   # set -u : exit the script if you try to use an uninitialized variable
set -o errexit   # set -e : exit the script if any statement returns a non-true return value

echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Welcome to using the KaTeX download script."

scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "$(date +'%0Y-%0m-%0d %0R:%0S'): The script directory is '$scriptDir'."
destDir="$scriptDir/../_site/assets/katex"
mkdir -p "$destDir"
destDir="$( cd "$destDir" && pwd )"
echo "$(date +'%0Y-%0m-%0d %0R:%0S'): The destination directory is '$destDir'."

cd /tmp/

for release in "latest" "279773203"; do
    echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Getting files of KaTeX release='$release' to download."
    data="$(curl -s https://api.github.com/repos/KaTeX/KaTeX/releases/$release)"
    files="$(grep browser_download_url <<< "$data" | sed -re 's/.*: "([^"]+)".*/\1/')"
    set +o errexit
    retcode="$?"
    set -o errexit
    if [ "$retcode" -ne 0 ]; then
      continue;
    fi

    for file in $files; do
		if [[ $file == *katex.tar.gz ]]; then
    		echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Downloading file '$file'."
			curl -s -L -o "katex.tar.gz" "$file"
			echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Done downloading file '$file', now unpacking."
			tar -xf "katex.tar.gz"
			mv katex/katex.min.* "$destDir/"
			mv katex/fonts "$destDir/"
			echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Done."
			exit 0
		elif [[ $file == *katex.zip ]]; then
    		echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Downloading file '$file'."
			curl -s -L -o "katex.zip" "$file"
			echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Done downloading file '$file', now unpacking."
			unzip "katex.zip"
			mv katex/katex.min.* "$destDir/"
			mv katex/fonts "$destDir/"
			echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Done."
			exit 0
		fi
    done
done

echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Failed to download KaTeX."
exit 1
