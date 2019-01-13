#!/bin/bash

set -e

host="$1"
shift

end_time=$(( $(printf '%(%s)T' -1) + 60 ))
while :; do
  psql -h "$host" -U "postgres" -c '\l' 2>&1 && break

  if (( $(printf '%(%s)T' -1) >= $end_time )); then
    echo >&2 'Taking too long to connect to Postgres, giving up'
    exit 1
  fi

  >&2 echo "Postgres is unavailable - sleeping"
  sleep 3
done

>&2 echo "Postgres is up - executing command: '$@'"
exec "$@"

