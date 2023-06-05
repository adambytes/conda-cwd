#  Create a conda virtual environment in the current directory called .conda
function ccwd() {
  local CURRENT_DIR=$(pwd)

  # Setting default python version
  local PYTHON_VERSION=${1:-3.11}

  # Checking if the version is valid
  if ! [[ $PYTHON_VERSION =~ ^[0-9]+\.[0-9]+$ ]]; then
    echo "Invalid Python version: $PYTHON_VERSION. Please enter a valid version (e.g., 3.11)."
    return 1
  fi

  if command -v conda &> /dev/null; then
    echo "Creating a conda environment in $CURRENT_DIR/.conda with Python version: $PYTHON_VERSION"

    # Checking if it exists first
    if [[ -d "${CURRENT_DIR}/.conda" ]]; then
      echo "Conda environment already exists."
      return 0
    else 
      conda create -p $CURRENT_DIR/.conda python=$PYTHON_VERSION
      conda activate ./.conda
      echo "Conda environment created."

      # Check if requriements.txt exists
      if [[ -f "${CURRENT_DIR}/requirements.txt" ]]; then
        echo "Installing requirements.txt"
        local failed_packages=""

        while read requirement; do
          if ! conda install -- yes $requirement; then
            failed_packages="${failed_packages} $requirement"
          fi
        done < "${CURRENT_DIR}/requirements.txt"

        for package in $failed_packages; do
          pip install $package || echo "Failed to install $package"
        done

      fi
    fi
  else 
    echo "Conda is not installed. Please install conda."
  fi
}
