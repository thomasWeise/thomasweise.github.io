#!/bin/bash -

# strict error handling
set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   # set -u : exit the script if you try to use an uninitialized variable
set -o errexit   # set -e : exit the script if any statement returns a non-true return value

echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Welcome to the script for including external data."

if [[ $(declare -p PYTHON_INTERPRETER 2>/dev/null) != declare\ ?x* ]]; then
  echo "$(date +'%0Y-%0m-%0d %0R:%0S'): No virtual environment found."
  venvDir="$(mktemp -d)"
  echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Got temp dir '$venvDir', now creating environment in it."
  python3 -m venv --upgrade-deps --copies "$venvDir"
  echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Activating virtual environment in '$venvDir'."
  source "$venvDir/bin/activate"
  export PYTHON_INTERPRETER="$venvDir/bin/python3"
  echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Setting python interpreter to '$PYTHON_INTERPRETER'."
  needCleanup=true
else
  echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Virtual environment with interpreter '$PYTHON_INTERPRETER' detected. Using that one."
  needCleanup=false
fi

echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Installing pycommons, urllib3, and certifi into virtual environment."
"$PYTHON_INTERPRETER" -m pip install pycommons==0.8.89 urllib3 certifi

echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Finished installing pycommons, urllib3, and certifi into virtual environment."

scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "$(date +'%0Y-%0m-%0d %0R:%0S'): The script directory is '$scriptDir'."

echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Now running program."
"$PYTHON_INTERPRETER" "$scriptDir/includeExternal.py" "$scriptDir/.."

if [ "$needCleanup" = true ]; then
  echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Deactivating virtual environment."
  deactivate
  if [ -d "$venvDir" ]; then
    echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Deleting virtual environment '$venvDir'."
    rm -rf "$venvDir"
  else
    echo "$(date +'%0Y-%0m-%0d %0R:%0S'): '$venvDir' is not a directory?."
  fi
fi

echo "$(date +'%0Y-%0m-%0d %0R:%0S'): Done with the script for including external data."
