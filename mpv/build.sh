#!/usr/bin/env bash

set -ex

cd "$(dirname "$0")"

baseFolder="$(pwd)"

brew install --build-from-source --only-dependencies mpv
brew install libplacebo

git clone "https://github.com/mpv-player/mpv"

cd mpv || exit 1

meson setup build
meson compile -C build

./build/mpv --version

./TOOLS/osxbundle.py --skip-deps build/mpv

dylibbundler --bundle-deps --dest-dir build/mpv.app/Contents/MacOS/lib/ --install-path @executable_path/lib/ --fix-file build/mpv.app/Contents/MacOS/mpv

./build/mpv.app/Contents/MacOS/mpv --version

find build/mpv.app

hdiutil create -volname mpv -srcfolder build/mpv.app -ov -format UDZO mpv.dmg

sha256sum mpv.dmg > mpv.dmg.sha256sum

mv mpv.dmg "$baseFolder"
mv mpv.dmg.sha256sum "$baseFolder"

