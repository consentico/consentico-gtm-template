# consentico-gtm-template

Google Tag Manager Community Template for [Consentico](https://consentico.com) — a Google-certified Consent Mode v2 implementation for Shopify, Wix, and any GTM-managed site.

This tag template:

- Sets the **Google Consent Mode v2 default state** with region-scoped denials for the EEA, UK, and Switzerland (per the EU User Consent Policy).
- Sets the recommended `ads_data_redaction` and `url_passthrough` flags for cookieless conversion modeling.
- Listens for the consentico banner's `cookieConsentUpdated` event and forwards the decision to GTM via `updateConsentState()`.

## Usage

1. In your GTM workspace, go to **Templates → Tag Templates → Search Gallery**.
2. Search for **Consentico** and click **Add to workspace**.
3. Create a new tag from the Consentico template.
4. Set the tag to fire on **Consent Initialization — All Pages**.
5. Publish your container.

## Configuration

| Field | Required | Default | Description |
|---|---|---|---|
| Shop ID | Yes | — | Your Consentico shop identifier (`*.myshopify.com` for Shopify, your domain otherwise). |
| Default region behavior | Yes | EEA-denied | One of: `EEA-denied` (denies in EEA/UK/CH only, grants elsewhere — recommended), `Global-denied` (denies everywhere), `Global-granted` (grants everywhere — not recommended). |
| Wait for update (ms) | No | 500 | How long Google tags should wait for an `update` call before firing with defaults. |
| Enable ads_data_redaction | No | true | Strips ad click identifiers from outgoing beacons when `ad_storage` is denied. |
| Enable url_passthrough | No | true | Forwards Google Ads click IDs through internal navigations via URL parameters when cookies are denied. |
| Load Consentico banner script | No | false | If true, loads `https://cdn.consentico.com/banner.js`. Use this if you are **not** on Shopify or Wix (where the banner is delivered as an app/extension). |

## Verification

After publishing the GTM container, visit your storefront in an incognito window with [Tag Assistant](https://tagassistant.google.com/) attached:

- EEA / UK / Switzerland visitors: GA4 fires with `gcs=G100` and all ad/analytics signals denied.
- Non-EEA visitors (default region behavior): GA4 fires with `gcs=G111` and all signals granted.
- After the visitor accepts the Consentico banner anywhere, GA4 fires again with `gcs=G111`.

If signals don't appear, confirm the tag is on the **Consent Initialization — All Pages** trigger (not just *All Pages*), so it runs before any other Google tag.

## Development

This template is developed inside the [consent-management monorepo](https://github.com/Great-Lock-In-2026/consent-management/tree/main/gtm-template) and mirrored to this public repo on each release. Open issues and pull requests against the [public repo](https://github.com/consentico/consentico-gtm-template).

## License

Apache 2.0 — see [LICENSE](./LICENSE).
