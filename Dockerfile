# Calibre-Web (linuxserver) met eigen aanpassingen voor Cloudflare Tunnel en de Wishlist-link.
# Versie-updates komen binnen via Dependabot-PR's; zie README.
FROM ghcr.io/linuxserver/calibre-web:0.6.27

COPY patches/ /tmp/patches/
COPY build/apply-customizations.sh /tmp/apply-customizations.sh
COPY static/wishlist.js /app/calibre-web/cps/static/wishlist.js
COPY root/ /

RUN sh /tmp/apply-customizations.sh && rm -rf /tmp/patches /tmp/apply-customizations.sh
