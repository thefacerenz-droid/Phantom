#!/bin/bash
set -euo pipefail

app_path="build/Build/Products/Release-iphoneos/Phantom.app"

test -d "$app_path"

package_dir="$(mktemp -d)"
trap 'rm -rf "$package_dir"' EXIT

mkdir -p "$package_dir/Payload"
cp -R "$app_path" "$package_dir/Payload/"

output_path="$PWD/build/Phantom-unsigned.ipa"

cd "$package_dir"
/usr/bin/zip -qr "$output_path" Payload

echo "Created: $output_path"
