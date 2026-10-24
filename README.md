# Calibre-Web

Calibre-Web (`ghcr.io/linuxserver/calibre-web`) met eigen aanpassingen, gedeployed via de standaard pipeline:
GitHub Actions → GHCR → Tailscale → Portainer (stack `calibre-web`) op de Synology.

## Aanpassingen

| Wat | Waar | Waarom |
|---|---|---|
| `X-Forwarded-Proto`/`-Port` en Cloudflare Tunnel-detectie | `patches/reverseproxy.patch` | Juiste https-URL's achter boekjes.gerdjan.nl, ook voor Kobo-sync |
| Wishlist-link in de navigatie | `static/wishlist.js` + script-tag in `layout.html` (`build/apply-customizations.sh`) | Doorklikken naar wishlist.gerdjan.nl |
| Calibre-tools (`ebook-convert`) | `Dockerfile` (stage `calibre-tools`) | Ingebakken i.p.v. `DOCKER_MODS`, zodat een herstart niet elke keer ~100 pakketten installeert |
| Autologin-key | `root/custom-cont-init.d/10-wishlist-key` | Key komt uit stack-env `WISHLIST_AUTOLOGIN_KEY`, niet uit repo of image |

## Stack-env (Portainer)

| Variabele | Betekenis |
|---|---|
| `HOST_PORT` | Poort op 192.168.68.120 (default 8086) |
| `BOOKS_MODE` | `ro` of `rw` voor de boekenmap (default `ro`) |
| `WISHLIST_AUTOLOGIN_KEY` | Moet gelijk zijn aan `AUTOLOGIN_KEY` van de Wishlist |

## Updates

- **Nieuwe Calibre-Web-versie:** Dependabot opent een PR die de `FROM`-tag ophoogt. Mergen = bouwen en deployen.
- **Security-rebuilds van dezelfde versie:** de workflow bouwt elke maandag 04:00 opnieuw en deployt.
- **Faalt de build** op `patch`, dan is `cps/reverseproxy.py` upstream veranderd. Maak de patch opnieuw:
  haal `cps/reverseproxy.py` van de nieuwe versie, pas de wijzigingen opnieuw toe en
  `diff -u a/cps/reverseproxy.py b/cps/reverseproxy.py > patches/reverseproxy.patch`.
  Er wordt dan niets gedeployed, de draaiende container blijft staan.
