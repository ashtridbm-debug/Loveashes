#!/usr/bin/env bash
# Wraps index.html (the Artifact source, which has no doctype or <head>) into a
# standalone page in dist/ for localhost and Vercel. Re-run after editing index.html.
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p dist
rm -rf dist/img
cp -r img dist/img
cp styles.css dist/styles.css
cp products.html dist/products.html
cp contact.html dist/contact.html

{
cat <<'HEAD'
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="description" content="Printable packaging templates for Filipino online sellers. Editable thank you stickers, logo labels and care cards.">
<style>
:root{
  color-scheme:light;
  padding-top:env(safe-area-inset-top,0px);
  padding-bottom:env(safe-area-inset-bottom,0px);
}
body{margin:0;font-family:system-ui,sans-serif;font-size:14px}
img{max-width:100%}
[hidden]{display:none!important}
</style>
HEAD

# index.html opens with <title>, <meta>, <link> and <style> — all head content —
# then the body markup. Split it at the first <nav.
sed -n '1,/^<nav>$/p' index.html | sed '$d'
echo '</head>'
echo '<body>'
sed -n '/^<nav>$/,$p' index.html
cat <<'FOOT'
</body>
</html>
FOOT
} > dist/index.html

echo "built dist/index.html ($(wc -c < dist/index.html) bytes)"
