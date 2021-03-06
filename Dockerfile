FROM hexpm/elixir:1.12.2-erlang-24.0.4-alpine-3.14.0

RUN apk upgrade --update-cache --available \
    && apk add build-base curl git tzdata vim wget

WORKDIR /blogex

RUN cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime \
    && echo "America/Sao_Paulo" > /etc/timezone

RUN apk del tzdata

RUN mix do local.hex --force, local.rebar --force

COPY . ./


CMD ["sh", "./start.sh"]
