# Vic Outdoors

Two trip-planning maps behind one Camping / Snorkelling toggle.

- **Camping** (`camp/`): Parks Victoria and Great Otway campgrounds with a 4-day forecast in 4-hour steps, plain-English regional summaries, a 7-day outlook, and live Parks Victoria site availability.
- **Snorkelling** (`snorkel/`): shore dive and snorkel sites around Melbourne, Port Phillip, Western Port and the Surf Coast, rated good, marginal or poor from wind, swell and tide for the next 4 days.

Open `index.html` through any web server (GitHub Pages, or `serve.ps1` below). Opening the file directly from disk won't work, because browsers block the live data requests from `file://` pages.

## Data sources

- Weather, swell and tide: [Open-Meteo](https://open-meteo.com/) (free, no key).
- Campsites and live availability: [Parks Victoria bookings](https://bookings.parks.vic.gov.au/book). This is the booking site's own data feed, not a published service, so it may change without notice.
- Great Otway drive-in campgrounds: [Great Ocean Road Coast and Parks Authority](https://www.greatoceanroadauthority.vic.gov.au/).
- Dive sites and ideal conditions: [Scuba Doctor dive site map](https://www.scubadoctor.com.au/melbourne-dive-sites-map.htm).
- Basemap: Esri World Topo Map with World Hillshade.

Forecasts and ratings are a guide only. Check official warnings at the [BoM](https://www.bom.gov.au/vic/) and [CFA](https://www.cfa.vic.gov.au/warnings-restrictions), and check conditions on arrival.

## Files

| File | What it is |
|---|---|
| `index.html` | Toggle page that holds both apps |
| `camp/index.html` | Camping app (all code and campsite data in one file) |
| `snorkel/index.html` | Snorkelling app |
| `snorkel/sites.js` | Dive sites, shore direction, exposure and webcams |
| `snorkel/guide.js` | Ideal-conditions notes per site |
| `serve.ps1` | Local preview server for Windows |
| `.nojekyll` | Tells GitHub Pages to serve the files as they are |

## Preview locally (Windows)

```
powershell -NoProfile -ExecutionPolicy Bypass -File serve.ps1
```

Then open http://localhost:8790/.

## Publish on GitHub Pages

1. Create a repository and upload everything in this folder (including `.nojekyll`).
2. Settings → Pages → Deploy from a branch → `main` / root → Save.
3. Settings → Collaborators → invite anyone who should be able to edit.
