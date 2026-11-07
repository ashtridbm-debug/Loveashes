# Love, Ashes

Marketing site for loveashes.co, printable packaging templates for Filipino online sellers.

Plain HTML and CSS. No framework, no dependencies.

## Files

| Path | What it is |
| --- | --- |
| `index.html` | Home page. Written without a `<!doctype>` or `<head>` so it can also be published as a Claude artifact; `build.sh` adds them. |
| `products.html` | Products page. A complete standalone document. |
| `contact.html` | Contact page. A complete standalone document. |
| `styles.css` | Shared stylesheet for all three pages. |
| `img/` | Logo and product images. |
| `build.sh` | Wraps `index.html` and copies everything into `dist/`. |
| `serve.py` | Local static server with the MIME types Python misses on Windows. |

## Run it locally

```bash
bash build.sh
python serve.py 4321
```

Then open http://127.0.0.1:4321

`serve.py` sends `Cache-Control: no-store`, so a plain refresh always shows the latest build.

## Deploy

Vercel reads `vercel.json`: it runs `bash build.sh` and serves `dist/`.

## Editing

Edit `index.html`, `products.html`, `contact.html` or `styles.css`, then re-run `build.sh`.
Never edit anything inside `dist/`, it is overwritten on every build.

Colours come from the logo and are declared once as tokens at the top of `styles.css`
(`--rose` is the heart pink, `--ink` the wordmark plum). Change them there and the whole
site follows.
