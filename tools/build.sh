#!/bin/sh
# Baut alle Vorlagen: <ID>_<Name>/src (Vorlagendateien) [+ icons (SVG)] -> dist/<ID>_<Name>.hst
# Mit eigenen Symbolen wird ein Symbolpaket <ID>.hsm erzeugt und mit eingepackt.
# Benötigt: Python 3, zip; für Symbole rsvg-convert (librsvg)
set -e
cd "$(dirname "$0")/.."
mkdir -p dist
for d in [0-9]*-[0-9]*_*/; do
  d=${d%/}; id=${d%%_*}; name=$(echo "${d#*_}" | tr '_' ' ')
  if [ -d "$d/icons" ]; then
    python3 tools/hsm-build.py --id "$id" --name "$name" --svg "$d/icons" --labels "$d/labels.txt" --hst "$d/src" --hst-out "dist/$d.hst"
  else
    rm -f "dist/$d.hst"; (cd "$d/src" && zip -qX "../../dist/$d.hst" *.xml); echo "dist/$d.hst"
  fi
done
