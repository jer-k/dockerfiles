FROM ruby:2.3
WORKDIR /usr/src/app/

#Copy the gem files and version (referenced in the .gemspec) into the WORKDIR
COPY <project_name>.gemspec .
COPY Gemfile .
COPY lib/version.rb lib/

RUN bundle check || bundle install

# Install psql so bin/wait_for_pg.sh will wait for the database to be up and running
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/postgresql.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update && apt-get -y install postgresql-client-9.6

#Copy the project into the WORKDIR
COPY . .
