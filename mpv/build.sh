#!/usr/bin/env bash

set -ex

uname -a | grep -q "arm64"

cd "$(dirname "$0")"

baseFolder="$(pwd)"

brew install --build-from-source --only-dependencies mpv
brew install libplacebo dylibbundler

git clone "https://github.com/mpv-player/mpv"

cd mpv || exit 1

meson setup build
meson compile -C build

./TOOLS/osxbundle.py --skip-deps build/mpv

dylibbundler --bundle-deps --dest-dir build/mpv.app/Contents/MacOS/lib/ --install-path @executable_path/lib/ --fix-file build/mpv.app/Contents/MacOS/mpv

#hdiutil create -volname mpv -srcfolder build/mpv.app -ov -format UDZO mpv.dmg

#shasum -a 256 mpv.dmg > mpv.dmg.sha256sum

version=$(./build/mpv --version | grep -o 'mpv[[:space:]]v[[:digit:].]*' | awk '{print $2}')

tar -czf "mpv-${version/v/}.tar.gz" build/mpv.app build/DOCS/man/mpv.1

echo "$version" > mpv.dmg.version

mv mpv.dmg "$baseFolder"
mv mpv.dmg.sha256sum "$baseFolder"
mv mpv.dmg.version "$baseFolder"

