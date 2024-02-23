# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the maintainer
LABEL maintainer="Andy Weaver <andrewayersweaver@gmail.com>"

# Set environment variables for versions of things
ENV NVIM_VERSION=0.9.5

# Set the working directory in the container
WORKDIR /usr/src/app

# Set the environment variable for linter/formatter
# configuration files
RUN mkdir -p /usr/src/config/
ENV CONFIG_DIR=/usr/src/config

# Set the environment variable for Neovim configuration files
RUN mkdir -p /root/.config/nvim/lua
ENV NVIM_DIR=/root/.config/nvim

# # Copy your Neovim plugin configuration files into the container
# COPY plugins.lua ${NVIM_DIR}/lua/plugins.lua
# COPY auto_install.lua ${NVIM_DIR}/lua/auto_install.lua
# COPY settings.lua ${NVIM_DIR}/lua/settings.lua

# Set the environment variable for Python
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the environment variable for Neovim
ENV XDG_CONFIG_HOME=/root/.config
ENV XDG_DATA_HOME=/root/.local/share


# Copy configuration files into the container
COPY ./.prettierrc ${CONFIG_DIR}/.prettierrc
COPY ./ruff.toml ${CONFIG_DIR}/ruff.toml


# Install system dependencies
RUN apt-get update && apt-get install -y \
  git \
  curl \
  software-properties-common \
  build-essential \
  # nodejs \
  python3-pip \
  python3-venv \
  python3-dev \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get autoremove -y \
  && apt-get clean

# # Verify that nodejs is installed
# RUN node -v

# Install Neovim
# Download and extract Neovim v0.9.5
RUN curl -LO https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux64.tar.gz && \
  tar xzf nvim-linux64.tar.gz && \
  rm nvim-linux64.tar.gz && \
  mv nvim-linux64 /usr/local && \
  ln -s /usr/local/nvim-linux64/bin/nvim /usr/local/bin/nvim

# Verify that Neovim is installed
RUN apt-get update -y && \
  apt-get upgrade -y && \
  apt-get full-upgrade -y && \
  nvim --version

RUN git clone https://github.com/aaweaver-actuary/kickstart.nvim.git \
  /usr/src/app/kickstart.nvim 

RUN mv /usr/src/app/kickstart.nvim/init.lua ${NVIM_DIR}/init.lua && \
  mv /usr/src/app/kickstart.nvim/.stylua.toml ${NVIM_DIR}/.stylua.toml && \
  cp -r /usr/src/app/kickstart.nvim/lua/ ${NVIM_DIR}/lua/ && \
  cp -r /usr/src/app/kickstart.nvim/doc/ ${NVIM_DIR}/nvim_docs/ && \
  rm -rf /usr/src/app/kickstart.nvim


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
  python3 -m pip install pynvim

# Create a virtual environment using python3-venv
RUN python3 -m venv .venv

# Activate the virtual environment and install Python packages
RUN . .venv/bin/activate && \ 
  python3 -m pip install --upgrade \
  ruff \
  ruff-lsp \
  flake8 \
  black \
  python-lsp-server \
  pynvim \
  isort

# Clone other Neovim plugins into the container
RUN git clone https://github.com/dense-analysis/ale.git \
  ~/.config/nvim/pack/ale/start/ale && \
  git clone https://github.com/github/copilot.vim.git \
  ~/.config/nvim/pack/github/start/copilot.vim

# Open headless Neovim to setup lazy package
RUN nvim --headless +qall

# Set the default command to run Neovim
CMD ["nvim"]
