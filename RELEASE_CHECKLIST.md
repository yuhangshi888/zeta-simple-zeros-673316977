# Release checklist

Every item in the first section was completed before the initial public
commit.  The later sections track publication and independent follow-up.

## Before the first public commit

- [x] Re-read `CLAIM_LEDGER.md`; no quarantined claim appears in the theorem.
- [x] Run `python3 verify_release.py` from a clean copy of the directory.
- [x] Compile `main.tex` and inspect every page of `main.pdf`.
- [x] Confirm the upstream commit and files in `UPSTREAM.lock` still resolve.
- [x] Confirm the public wording says “research-draft candidate,” not
      “peer-reviewed,” “formally verified,” or “independently recertified.”
- [x] Decide whether the proposed MIT license is the author's intended legal
      choice; replace it before publication if not.

## GitHub publication

- [ ] Create the repository and upload the complete manifest-tracked tree.
- [ ] Confirm the `verify` GitHub Actions job is green on the public commit.
- [ ] Make the headline number, paper, proof outline, exact result, trust
      boundary, and one-command check visible above the README fold.
- [ ] Create an immutable tag `v0.1.0` and a GitHub Release named
      `67.3316977142% research-draft candidate`; attach `main.pdf` if desired.
- [ ] Record the release commit SHA in any announcement.
- [ ] Archive the tagged release with Zenodo or another permanent repository,
      then add the DOI to `CITATION.cff` and the README.

## Independent scrutiny

- [ ] Send the exact commit and `REVIEW_GUIDE.md` to the maintainers of the
      imported certificate repository and suitable analytic-number-theory
      readers; request checks, not endorsement.
- [ ] Preserve all corrections in `CHANGELOG.md` and never rewrite a released
      tag.
- [ ] If an error affects the theorem, mark the README immediately and issue
      a new version rather than silently editing the claim.
