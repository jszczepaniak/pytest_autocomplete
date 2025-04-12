# zsh-pytest-fzf

🎯 A Zsh plugin that lets you select pytest tests using `fzf` and insert them into your terminal.

## ✨ Features

- Supports parameterized tests like `tests/test_basic.py::test_customers[/v1-200]`
- Uses `pytest --collect-only -q` to dynamically list tests
- Presents test list via `fzf`
- Inserts the selected test into the current command line
- Binds to `Ctrl+P` for quick access
- Automatically adds quotes around test names that contain special characters (like `[]` for parametrized tests)

## 🧰 Requirements

- [`fzf`](https://github.com/junegunn/fzf)
- [`pytest`](https://docs.pytest.org/)
- Zsh shell + [Oh My Zsh](https://ohmyz.sh)

## ⚙️ Installation

### 1. Clone the plugin into your Oh My Zsh custom plugins directory

Run the following command to clone the repository:

```bash
git clone https://github.com/jszczepaniak/pytest_autocomplete ~/.oh-my-zsh/custom/plugins/zsh-pytest-fzf
```

## 2. Plugin activation

Add the plugin to your `~/.zshrc` file, for example:

```
plugins=(git zsh-pytest-fzf)
```

Load the new configuration:

```bash
source ~/.zshrc
```