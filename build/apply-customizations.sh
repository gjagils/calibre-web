#!/bin/sh
# Past de eigen aanpassingen toe op de upstream Calibre-Web code in het image.
# Faalt dit, dan is upstream veranderd en moet de patch opnieuw gemaakt worden (zie README).
set -eu
APP=/app/calibre-web

apt-get update
apt-get install -y --no-install-recommends patch
patch -d "$APP" -p1 --forward --batch < /tmp/patches/reverseproxy.patch
apt-get purge -y patch
rm -rf /var/lib/apt/lists/*

# Wishlist-link: script laden onderaan elke pagina
LAYOUT="$APP/cps/templates/layout.html"
sed -i "s#</body>#  <script src=\"{{ url_for('static', filename='wishlist.js') }}\"></script>\n  </body>#" "$LAYOUT"
[ "$(grep -c 'wishlist.js' "$LAYOUT")" -eq 1 ] || { echo "wishlist.js niet (precies 1x) in $LAYOUT"; exit 1; }

chmod +x /custom-cont-init.d/*
