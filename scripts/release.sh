#!/usr/bin/env bash
# Release helper for the Consentico GTM Community Template.
#
# Usage:
#   gtm-template/scripts/release.sh v1.0.0
#
# What this does:
#   1. Validates that gtm-template/CHANGELOG.md has a heading for the version.
#   2. Tags the monorepo with `gtm-template/<version>`.
#   3. Pushes the tag, which triggers the mirror workflow to push the same
#      tag (without the `gtm-template/` prefix) to consentico/consentico-gtm-template.
#   4. Prints the next manual steps: fetch the mirror commit SHA, update
#      metadata.yaml, and open the Community Template Gallery PR.

set -euo pipefail

if [ "${1:-}" = "" ]; then
  echo "Usage: $0 vX.Y.Z" >&2
  exit 1
fi

VERSION="$1"

if [[ ! "${VERSION}" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Version must look like vX.Y.Z (got: ${VERSION})" >&2
  exit 1
fi

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "${REPO_ROOT}"

CHANGELOG="gtm-template/CHANGELOG.md"
if ! grep -q "^## \[${VERSION#v}\]" "${CHANGELOG}"; then
  echo "ERROR: ${CHANGELOG} has no heading for ${VERSION#v}." >&2
  echo "       Add a '## [${VERSION#v}] — YYYY-MM-DD' section before tagging." >&2
  exit 1
fi

TAG="gtm-template/${VERSION}"

if git rev-parse "${TAG}" >/dev/null 2>&1; then
  echo "ERROR: Tag ${TAG} already exists locally." >&2
  exit 1
fi

if [ -n "$(git status --porcelain)" ]; then
  echo "ERROR: Working tree has uncommitted changes. Commit or stash first." >&2
  exit 1
fi

git tag -a "${TAG}" -m "gtm-template ${VERSION}"
git push origin "${TAG}"

cat <<EOF

Tag ${TAG} pushed.

Next steps (manual):

  1. Wait for the 'Mirror GTM template to public repo' workflow to finish.
     It will push tag ${VERSION} to consentico/consentico-gtm-template.

  2. Capture the mirror commit SHA:
       git ls-remote https://github.com/consentico/consentico-gtm-template.git refs/tags/${VERSION}

  3. Update gtm-template/metadata.yaml: set versions[0].sha to the mirror SHA
     and confirm changeNotes match gtm-template/CHANGELOG.md.

  4. Commit the metadata.yaml update on main and re-run the mirror workflow
     (this overwrites the tagged release with the SHA-pinned metadata.yaml,
     which is what the Gallery PR will reference).

  5. Submit the template at https://tagmanager.google.com/gallery
     (vertical dots → Submit Template). See
     gtm-template/scripts/gallery-submission.md for the exact form fields.

EOF
