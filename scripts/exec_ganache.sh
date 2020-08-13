#!/usr/bin/env bash

NODO_DIRECTORY="${HOME}/nodo-dir/securitize/"
GANACHE_PORT=7545
NETWORKD_ID=5777

# Exit script as soon as a command fails.
set -o errexit

# Executes cleanup function at script exit.
trap cleanup EXIT

cleanup() {
  if [ -n "$ganache_pid" ] && ps -p $ganache_pid > /dev/null; then
    kill -9 $ganache_pid
  fi
}

ganache_running() {
  nc -z localhost "$GANACHE_PORT"
}

start_ganache() {
  local accounts=(
    --account="0x2bdd21761a483f71054e14f5b827213567971c676928d9a1808cbfa4b7501200,100000000000000000000000000"
    --account="0x2bdd21761a483f71054e14f5b827213567971c676928d9a1808cbfa4b7501201,100000000000000000000000000"
    --account="0x2bdd21761a483f71054e14f5b827213567971c676928d9a1808cbfa4b7501202,100000000000000000000000000"
    --account="0x2bdd21761a483f71054e14f5b827213567971c676928d9a1808cbfa4b7501203,100000000000000000000000000"
    --account="0x2bdd21761a483f71054e14f5b827213567971c676928d9a1808cbfa4b7501204,100000000000000000000000000"
    --account="0x2bdd21761a483f71054e14f5b827213567971c676928d9a1808cbfa4b7501205,100000000000000000000000000"
    --account="0x2bdd21761a483f71054e14f5b827213567971c676928d9a1808cbfa4b7501206,100000000000000000000000000"
    --account="0x2bdd21761a483f71054e14f5b827213567971c676928d9a1808cbfa4b7501207,100000000000000000000000000"
    --account="0x2bdd21761a483f71054e14f5b827213567971c676928d9a1808cbfa4b7501208,100000000000000000000000000"
    --account="0x2bdd21761a483f71054e14f5b827213567971c676928d9a1808cbfa4b7501209,100000000000000000000000000"
  )
  if [ ! -d "$NODO_DIRECTORY" ]; then
    mkdir -p "$NODO_DIRECTORY"
  fi

  node_modules/.bin/ganache-cli --db "$NODO_DIRECTORY" --gasLimit 0xfffffffffff "${accounts[@]}" -i $NETWORKD_ID --port $GANACHE_PORT

  ganache_pid=$!
}

if ganache_running; then
  echo "Ganache was running"
else
  echo "Run ganache"
  start_ganache
fi

ganache-cli --version
truffle version
