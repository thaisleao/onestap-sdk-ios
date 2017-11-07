#!/bin/bash
# fail if any commands fails
set -e

FRAMEWORK_NAME="OnestapSDK FingerPrint_iOS"

brew update
brew outdated carthage || brew upgrade carthage
carthage build --no-skip-current
carthage archive $FRAMEWORK_NAME