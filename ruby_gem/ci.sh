#!/bin/bash -e

docker-compose build --pull
# run the ci task
docker-compose -f docker-compose.yml \
  -e "RAILS_ENV=test" \
  -e "COVERAGE=true" \
  -w "/app" \
  app bundle exec rake spec
