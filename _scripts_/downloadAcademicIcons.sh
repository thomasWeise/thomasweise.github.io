#!/bin/bash -

# strict error handling
set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   # set -u : exit the script if you try to use an uninitialized variable
set -o errexit   # set -e : exit the script if any statement returns a non-true return value

echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Welcome to using the Academic Icons Font download script."

destDir="$1"
mkdir -p "$destDir"
destDir="$( cd "$destDir" && pwd )"
echo "$(date +'%0Y-%0m-%0d %0R:%0S'): The destination directory is '$destDir'."

cd /tmp/

for release in "latest" "242528499"; do
    echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Getting files of Academic Icons Font release='$release' to download."
    set +o errexit
    data="$(curl -s https://api.github.com/repos/jpswalsh/academicons/releases/$release)"
    files="$(grep tarball_url <<< "$data" | sed -re 's/.*: "([^"]+)".*/\1/')"
    retcode="$?"
    set -o errexit
    if [ "$retcode" -ne 0 ]; then
      continue;
    fi

    for file in $files; do
    	echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Downloading file '$file'."
			curl -s -L -o "ai.tar.gz" "$file"
			echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Done downloading file '$file', now unpacking."
			tar -xf "ai.tar.gz"
      set +o errexit
      name="$(find /tmp/ -maxdepth 1 -name "jpswalsh-*" -type d)"
      set -o errexit
      if [ "$retcode" -ne 0 ]; then
        continue;
      fi
      sed -i 's/..\/fonts\/academicons/fonts\/academicons/g' "$name/css/academicons.min.css"
			mv "$name/css/academicons.min.css" "$destDir/"
			mv "$name/fonts" "$destDir/"
			echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Done."
			exit 0
    done
done

echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Failed to download Academic Icons Font."
exit 1
