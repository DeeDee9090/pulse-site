# PULSE landing site

A static landing page + user guide for **PULSE** — a command centre for Microsoft
Solution Engineers (weekly milestone reporting, an 8-motion execution scorecard, CAF
nominations, territory whitespace, and an FY Connect generator).

This repo contains **only the public marketing/onboarding site**. It holds no
customer data, no API, and no credentials. The live dashboard (with sign-in and the
Azure Functions API) is hosted separately on Azure Static Web Apps.

## Structure

```
index.html        Landing page (hero, features, how-it-works, get-started)
userguide.html    Step-by-step user guide
assets/site.css   Styles
assets/site.js    Small interactivity (mobile nav, scroll reveal)
images/           Screenshots (see images/README.md)
```

## Run locally

Just open `index.html` in a browser, or serve the folder:

```powershell
python -m http.server 8080
# then visit http://localhost:8080
```

## Publishing (GitHub Pages)

Enable Pages on this repo (Settings → Pages → deploy from `main`, root). The site
publishes at `https://<user>.github.io/<repo>/`.

## Adding screenshots

See [`images/README.md`](images/README.md). Files dropped there appear automatically;
until then the page shows styled placeholder frames.
