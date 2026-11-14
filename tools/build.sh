#!/bin/sh
# Baut alle Vorlagen: <ID>_<Name>/src (Vorlagendateien) + icons (SVG) -> dist/<ID>_<Name>.hst
# Benötigt: Python 3, rsvg-convert (librsvg)
set -e
cd "$(dirname "$0")/.."
mkdir -p dist
for d in [0-9]*-[0-9]*_*/; do
  d=${d%/}; id=${d%%_*}; name=$(echo "${d#*_}" | tr '_' ' ')
  python3 tools/hsm-build.py --id "$id" --name "$name" --svg "$d/icons" --labels "$d/labels.txt" --hst "$d/src" --hst-out "dist/$d.hst"
done
