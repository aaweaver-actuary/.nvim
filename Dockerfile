# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Install system dependencies
RUN apt-get update && apt-get install -y \
  neovim \
  git \
  curl \
  && rm -rf /var/lib/apt/lists/*

# Install Powerline
RUN pip install powerline-status

# Install ruff and flake8 for Python linting
RUN pip install ruff flake8

# Install Black for Python formatting
RUN pip install black

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

# Install Neovim plugins using a non-interactive shell
RUN nvim --headless +PlugInstall +qall

# Set the default command to run Neovim
CMD ["nvim"]
