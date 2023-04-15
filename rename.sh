#! /bin/bash

set -e
set -x

APP_NAME='SearchMagic'

flutter pub global run rename --bundleId hellodword.searchmagic

flutter pub global run rename --appname "$APP_NAME" --target ios
flutter pub global run rename --appname "$APP_NAME" --target android
flutter pub global run rename --appname "$APP_NAME" --target web
flutter pub global run rename --appname "$APP_NAME" --target macOS
flutter pub global run rename --appname "$APP_NAME" --target windows
flutter pub global run rename --appname "$APP_NAME" --target linux