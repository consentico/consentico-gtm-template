# Changelog

All notable changes to the Consentico GTM Community Template will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] — 2026-06-13

### Added

- Region-scoped Google Consent Mode v2 defaults for the EEA, UK, and Switzerland (per the EU User Consent Policy), with a global fallback for non-EEA visitors.
- Three preset region behaviours: `EEA-denied` (recommended), `Global-denied`, and `Global-granted`.
- Optional `ads_data_redaction` and `url_passthrough` flags forwarded to `gtag('set', ...)`.
- `cookieConsentUpdated` event listener that maps the consentico banner's `analytics`/`marketing`/`preferences` decisions to `ad_storage`, `ad_user_data`, `ad_personalization`, `analytics_storage`, and `personalization_storage` via `updateConsentState()`.
- Optional injection of the consentico banner script (`https://cdn.consentico.com/banner.js`) for non-Shopify, non-Wix sites.
- `___TESTS___` scenarios covering EEA-denied defaults, global-denied/granted defaults, flag forwarding, banner consent updates, and banner injection success/skip paths.

[1.0.0]: https://github.com/consentico/consentico-gtm-template/releases/tag/v1.0.0
