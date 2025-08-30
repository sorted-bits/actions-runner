docker kill runner
docker rm runner

docker run \
  --detach \
  --env ORG="$1" \
  --env ACCESS_TOKEN="$2" \
  --name runner \
  runner-image