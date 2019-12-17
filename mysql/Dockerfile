# syntax = docker/dockerfile:experimental

# Build Command
# DOCKER_BUILDKIT=1 docker build --build-arg CACHEBUST=$(date +%s) \
# --build-arg S3_BUCKET=<bucket_name> \ 
# --build-arg MYSQL_VERSION=<bucket_name> \ 
# -t <database_image_name> --secret id=aws,src=$HOME/.aws/credentials .

ARG MYSQL_VERSION

FROM python:3 as builder
RUN pip install awscli

ARG S3_BUCKET
ARG CACHEBUST
RUN --mount=type=secret,id=aws,target=/root/.aws/credentials \
    aws s3 cp s3://${S3_BUCKET}/db-data.sql db-data.sql

FROM mysql:${MYSQL_VERSION}

COPY --from=builder db-data.sql /docker-entrypoint-initdb.d/
