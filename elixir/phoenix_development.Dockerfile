FROM elixir:1.10.2-alpine

RUN mix local.hex --force \
 && mix archive.install --force hex phx_new 1.5.1 \
 && mix local.rebar --force

 RUN apk --no-cache --update upgrade && \ 
 apk add --no-cache --update build-base \
                             inotify-tools \
                             linux-headers \
                             bash \
                             postgresql-dev \
                             nodejs \
                             npm \
                             postgresql-client \
                             less
                  
RUN npm -v
RUN npm install -g yarn

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY config/* config/
COPY mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

COPY assets/* assets/
RUN cd assets && yarn install --check-files

COPY . ./

CMD ["mix", "phx.server"]

