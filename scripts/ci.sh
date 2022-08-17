#!/usr/bin/env bash

set -e

# Find the root of the repo
__repo=$(cd $(dirname ${BASH_SOURCE[0]})/..; pwd -P)

${__repo}/ci/build-image.sh
