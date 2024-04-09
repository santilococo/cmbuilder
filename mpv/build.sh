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

appDir="build/mpv.app"

dylibbundler --bundle-deps --dest-dir "$appDir"/Contents/MacOS/lib/ --install-path @executable_path/lib/ --fix-file "$appDir"/Contents/MacOS/mpv

sed -i '' -e "s/-UNKNOWN//" -e "s/\(public\.app-category\)\.games/\1\.video/" "$appDir"/Contents/Info.plist

tarball="mpv.tar.gz"

tar -czf "$tarball" --strip-components=1 "$appDir" build/mpv.1

shasum -a 256 "$tarball" > "$tarball".sha256sum

version=$(./build/mpv --version | grep -o 'mpv[[:space:]]v[[:digit:].]*' | awk '{print $2}')

echo "$version" > "$tarball".version

mv "$tarball" "$baseFolder"
mv "$tarball".sha256sum "$baseFolder"
mv "$tarball".version "$baseFolder"

