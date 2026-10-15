#!/usr/bin/env bash
set -euo pipefail

# Run from the root of a checked-out Charge repository after copying this bundle's
# package.json, capacitor.config.json, and .github/workflows/build-apk.yml into it.
if [ ! -f index.html ] && [ ! -f www/index.html ]; then
  echo "ERROR: Could not find index.html in repository root or www/"
  exit 1
fi

mkdir -p www
if [ ! -f www/index.html ] && [ -f index.html ]; then
  cp index.html www/index.html
  echo "Copied existing index.html to www/index.html"
fi

npm install --no-audit --no-fund
if [ ! -d android ]; then
  npx cap add android
fi
npx cap sync android
echo "Android project prepared. Use GitHub Actions to build the APK, or configure Android SDK to build locally."
