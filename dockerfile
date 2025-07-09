FROM debian:bookworm-slim AS base

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install debian-keyring curl git -y
RUN apt-get install debian-archive-keyring -y
RUN apt-get install apt-transport-https -y 

RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list

RUN chmod o+r /usr/share/keyrings/caddy-stable-archive-keyring.gpg
RUN chmod o+r /etc/apt/sources.list.d/caddy-stable.list

RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash -

RUN apt-get update
RUN apt-get install caddy -y

RUN apt-get install -y nodejs


ENV PNPM_HOME=/pnpm/store
ENV PATH=$PNPM_HOME:$PATH
ENV SHELL=bash
RUN curl -fsSL https://get.pnpm.io/install.sh | bash -

RUN pnpm setup 

FROM base 

