# Calibre-Web (linuxserver) met eigen aanpassingen voor Cloudflare Tunnel en de Wishlist-link.
# Versie-updates komen binnen via Dependabot-PR's; zie README.

# Calibre-tools (ebook-convert) uit de universal-calibre mod; de wekelijkse herbouw haalt de nieuwste versie op
FROM ghcr.io/linuxserver/mods:universal-calibre AS calibre-tools

FROM ghcr.io/linuxserver/calibre-web:0.6.27

COPY --from=calibre-tools /calibre.txz /tmp/calibre.txz
COPY patches/ /tmp/patches/
COPY build/apply-customizations.sh /tmp/apply-customizations.sh
COPY static/wishlist.js /app/calibre-web/cps/static/wishlist.js
COPY root/ /

RUN sh /tmp/apply-customizations.sh && rm -rf /tmp/patches /tmp/apply-customizations.sh /tmp/calibre.txz
