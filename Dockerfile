FROM rafaelri/buildbot-worker-stretch
USER root
RUN apt-get update && apt-get install -y docker make build-essential libssl-dev zlib1g-dev libbz2-dev \
     libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
     xz-utils tk-dev libffi-dev liblzma-dev python-openssl git && \
     rm -rf /var/lib/apt/lists/*
RUN chmod u+s /usr/bin/docker
RUN echo 'export PATH=${HOME}/.pyenv/bin:$PATH' >> /etc/profile
USER buildbot
ENV PYENV_ROOT="${HOME}/.pyenv"
RUN git clone --depth 1 https://github.com/yyuu/pyenv.git ~/.pyenv && \
    rm -rf ~/.pyenv/.git && \
      echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc && \
      echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc && \
      echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc && \
      mkdir -p ${HOME}/.pyenv/versions && \
      mkdir -p ${HOME}/.pyenv/shims
RUN git clone https://github.com/pyenv/pyenv-virtualenv.git ${HOME}/.pyenv/plugins/pyenv-virtualenv && \
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc