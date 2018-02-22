#!/usr/bin/env bash
docker pull codeclimate/codeclimate
docker pull codeclimate/codeclimate-rubocop:rubocop-0-52

docker run \
  --interactive --rm \
  --env CODE_PATH="$PWD" \
  --volume "$PWD":/code \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume /tmp/cc:/tmp/cc \
  codeclimate/codeclimate analyze 2>&1 > /tmp/codeclimate.$$

cat /tmp/codeclimate.$$

OUTPUT=$(grep -i 'found 0 issues' /tmp/codeclimate.$$)
rm /tmp/codeclimate.$$

if [ -z "$OUTPUT" ]; then
  exit 1
fi