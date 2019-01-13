FROM ruby:2.5.0-alpine
WORKDIR /usr/src/app/

RUN apk --update add --no-cache --virtual run-dependencies \
  bash \
  build-base \
  postgresql-client \
  postgresql-dev \
  git

#Copy the gem files into the WORKDIR
COPY gem_with_database.gemspec .
COPY Gemfile .
COPY lib/gem_with_database/version.rb lib/gem_with_database/

RUN bundle check || bundle install

COPY . .
