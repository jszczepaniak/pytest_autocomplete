# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}


check_dependencies() {
  # Check if fzf is installed
  if ! command_exists fzf; then
    echo "fzf is not installed. Please install fzf to continue."
    echo "You can install it via Homebrew (macOS): brew install fzf"
    echo "Or via APT (Ubuntu/Debian): sudo apt-get install fzf"
    echo "Or via your package manager of choice."
    return 1  # Stop the script if fzf is not installed
  fi

  # Check if pytest is installed
  if ! command_exists pytest; then
    echo "pytest is not installed. Please install pytest to continue."
    echo "You can install it via pip: pip install pytest"
    return 1  # Stop the script if pytest is not installed
  fi
}

# Dynamically collects pytest test list and inserts selected test via fzf

# Function to handle test selection via fzf
fzf-pytest-test-selector() {
  # Check if fzf and pytest are installed
  check_dependencies || return 1

  # Collect pytest tests and pass them to fzf
  local selected_test
  if command_exists python; then
    selected_test=$(python -m pytest --collect-only -q 2>/dev/null | fzf)
  else
    selected_test=$(python3 -m pytest --collect-only -q 2>/dev/null | fzf)
  fi

  # If a test was selected, insert it into the command line
  if [[ -n "$selected_test" ]]; then
    # Add quotes only if the test path contains square brackets (parametrized test)
    if [[ "$selected_test" == *'['*']'* ]]; then
      LBUFFER+="'$selected_test'"
    else
      LBUFFER+="$selected_test"
    fi
    zle redisplay
  fi
}

# Create the widget and bind it to Ctrl+P
zle -N fzf-pytest-test-selector
bindkey '^P' fzf-pytest-test-selector
