#! /bin/bash
basePath=$(cd "$(dirname "$0")";pwd)
cd $basePath
pod repo push FMPodSpec FMFormSubmitKit.podspec --allow-warnings &&
pod trunk push FMFormSubmitKit.podspec --allow-warnings

