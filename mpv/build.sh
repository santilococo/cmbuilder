#!/usr/bin/env bash

set -ex

baseFolder="$(pwd)"

cd "$(dirname "$0")"

brew install --build-from-source --only-dependencies mpv
brew install libplacebo

git clone "https://github.com/mpv-player/mpv"

cd mpv || exit 1

meson setup build
meson compile -C build

./build/mpv --version

./TOOLS/osxbundle.py --skip-deps build/mpv

pkgName="$(find "$(pwd)" -type d -name "*.app")"

echo "$pkgName" | sed "s|^$baseFolder/||"
