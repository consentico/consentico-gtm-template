# Community Template Gallery submission

Submission to the [Google Tag Manager Community Template Gallery](https://tagmanager.google.com/gallery)
is **form-based**, not a pull request. (Earlier guidance referred to a
`googletagmanager/gtm-templates-community-template-gallery` repo; that
repo no longer exists. The current flow is the in-product submission
form.)

## Pre-submission checklist

Before opening the form, confirm all of the following on
`https://github.com/consentico/consentico-gtm-template`:

- [ ] `template.tpl`, `metadata.yaml`, `LICENSE`, and `README.md` are at the **repo root**, on the **`main` branch**.
- [ ] The repo is **public**.
- [ ] `metadata.yaml` `versions[0].sha` is the mirror commit that contains the v1.0.0 `template.tpl` (run `git ls-remote https://github.com/consentico/consentico-gtm-template.git refs/tags/v1.0.0`).
- [ ] The `v1.0.0` tag exists on the mirror.
- [ ] All `___TESTS___` scenarios pass when the template is imported into the GTM template editor (Tests tab → Run All).
- [ ] The placeholder thumbnail in `template.tpl`'s `INFO.brand` is the real Consentico logo (96×96 PNG, base64).

## Submission form

1. Sign into <https://tagmanager.google.com/gallery> with the GitHub-linked Google account that has access to `consentico/consentico-gtm-template`.
2. Click the vertical dots → **Submit Template**.
3. Fill in:

   | Field | Value |
   |---|---|
   | Repository URL | `https://github.com/consentico/consentico-gtm-template` |
   | Template type | `Tag` |
   | Description | `Google Consent Mode v2 implementation by Consentico — region-scoped EEA defaults, ads_data_redaction, url_passthrough, and consentico banner integration.` |
   | Contact email | `support@consentico.com` |

4. Submit. Reviews are asynchronous (typically 1–4 weeks). Monitor at <https://tagmanager.google.com/gallery/#/template/consentico/consentico-gtm-template/status>.

## Post-approval

Update [marketing/content/docs/google-consent-mode-v2-setup.mdx](../../marketing/content/docs/google-consent-mode-v2-setup.mdx)
to drop the "submission pending" note and link directly to the live
gallery entry.

## Subsequent versions

For each new release (vX.Y.Z):

1. Update [CHANGELOG.md](../CHANGELOG.md) with a new heading.
2. Run `gtm-template/scripts/release.sh vX.Y.Z` from the monorepo root.
3. After the mirror workflow tags the public repo, prepend a new entry to `metadata.yaml` `versions:` with the mirror SHA and `changeNotes`.
4. The Gallery picks up the new version automatically within 2–3 days.
