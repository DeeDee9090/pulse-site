# PULSE landing site

A static landing page + complete Power Apps user guide for **PULSE** — a command
centre for Microsoft Solution Engineers covering Weekly Milestones, PULSE Tracker,
Portfolio workspaces, guarded MSX operations, CAF and FY27 Connect preparation.

This repo contains **only the public marketing/onboarding site**. It holds no
customer data, no API, and no credentials. The live product is the separately
deployed PULSE Production Power App and runs in the signed-in user's work context.

## Structure

```
index.html        Landing page (hero, features, videos, how-it-works, get-started)
userguide.html    Complete Power Apps user guide with detailed Connect workflow
assets/site.css   Styles
assets/site.js    Small interactivity (mobile nav, scroll reveal)
images/           Screenshots (see images/README.md)
videos/           Fabricated-data product walkthroughs for Weekly, Tracker and Connect
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
