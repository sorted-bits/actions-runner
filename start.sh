#!/bin/bash

REPO=$REPO
ORG=$ORG
ACCESS_TOKEN=$ACCESS_TOKEN
RUNNER_GROUP=${RUNNER_GROUP:-"Default"}

if [[ -z $REPO && -z $ORG ]]; then
  echo "You must set the REPO or ORG environment variable"
  exit 1
fi

if [[ -z "${REPO}" && -n "${ORG}" ]]; then
    URL=https://api.github.com/orgs/${ORG}/actions/runners/registration-token
    VALUE=${ORG}
fi

if [[ -z "${ORG}" && -n "${REPO}" ]]; then
    URL=https://api.github.com/repos/${REPO}/actions/runners/registration-token
    VALUE=${REPO}
fi

REG_TOKEN=$(curl -sX POST -H "Authorization: token ${ACCESS_TOKEN}" -H "Accept: application/vnd.github+json" ${URL} | jq .token --raw-output)

cd /home/docker/actions-runner

./config.sh --url https://github.com/${VALUE} --token ${REG_TOKEN} --runnergroup ${RUNNER_GROUP}

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!