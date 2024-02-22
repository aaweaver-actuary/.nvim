# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Install system dependencies
RUN apt-get update && apt-get install -y \
  neovim \
  git \
  curl \
  software-properties-common \
  build-essential \
  nodejs \
  python3-pip \
  python3-venv \
  python3-dev \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get autoremove -y \
  && apt-get clean

# Verify that nodejs is installed
RUN node -v

# Verify that Neovim is installed
RUN nvim --version

# Set the environment variable for Neovim
ENV XDG_CONFIG_HOME=/root/.config
ENV XDG_DATA_HOME=/root/.local/share

# Verify that:
# 1. python3 is installed
# 2. python3 is available on the PATH
# 3. pip is installed
# 4. pip is available on the PATH
# 5. python3-venv is installed
RUN python3 --version
RUN which python3 
RUN pip --version 
RUN which pip 
RUN python3 -m venv --help 

# Update pip and install global Python packages
RUN python3 -m pip install --upgrade pip && \
  python3 -m pip install \
  pynvim  # Add other packages here if needed globally


# Create a virtual environment using python3-venv
RUN python3 -m venv .venv

# Activate the virtual environment and install Python packages
RUN . .venv/bin/activate && \ 
  python3 -m pip install --upgrade \
  ruff \
  ruff-lsp \
  flake8 \
  black \
  powerline-status \
  python-lsp-server \
  pynvim \
  isort

# Install Powerline fonts
RUN git clone https://github.com/powerline/fonts.git --depth=1 && \
  cd fonts && \
  ./install.sh && \
  cd .. && \
  rm -rf fonts

# Install vim-plug for Neovim
RUN curl -fLo "${XDG_DATA_HOME:-/root/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copy your Neovim configuration file into the container
COPY init.vim /root/.config/nvim/init.vim

# Install Neovim plugins
# This is tricky because Neovim expects a tty, so we fake it with expect
RUN apt-get update && apt-get install -y expect && \
  echo 'expect "Press ENTER or type command to continue" {send "\r"}' > install_plugins.exp && \
  echo 'spawn nvim --headless +PlugInstall +qall' >> install_plugins.exp && \
  expect install_plugins.exp && \
  rm install_plugins.exp && \
  apt-get remove -y expect && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Install copilot.vim
RUN git clone https://github.com/github/copilot.vim.git \
  ~/.config/nvim/pack/github/start/copilot.vim && \
  nvim --headless +PlugInstall +qall

# Install Neovim plugins using a non-interactive shell
RUN nvim --headless +PlugInstall +qall

# Set the default command to run Neovim
CMD ["nvim"]
