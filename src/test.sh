#!/usr/bin/env bash

EXPECTED_OUTPUT="Here is some data!"

echo "Running tests..."

if [ "$(node src/index.js)" == "$EXPECTED_OUTPUT" ]; then
  echo "All tests passed!"
  exit 0
else
  echo "Tests failed! Expected '$EXPECTED_OUTPUT' but got '$(node src/index.js)'"
  exit 1
fi