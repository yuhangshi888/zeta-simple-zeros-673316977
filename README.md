# Two-certificate trace--energy deduction

This directory contains a short research draft giving the candidate lower
bound

\[
\liminf_{T\to\infty}\frac{N_0^s(T,2T)}{N(T,2T)}
\ge 0.6733169771424713\ldots>0.673316977.
\]

The new step is purely finite-dimensional: the certified seven- and
nine-point gap inequalities are retained simultaneously and absorbed by a
supporting plane of `Phi_m`.  It reuses, without modification, the certified
window and both local inequalities from
[`trmdy/zeta-simple-zeros-673137`](https://github.com/trmdy/zeta-simple-zeros-673137)
at commit `1610b97b7895ff34982260f8dcaf04a0f7b82cf7`.

**[Paper](main.pdf)** · **[Proof outline](PROOF_OUTLINE.md)** ·
**[Exact result](RESULT.json)** · **[Independent review guide](REVIEW_GUIDE.md)**

The value is `67.3316977142471...%`, compared with the pinned upstream
candidate `67.3312742272246...%`; the numerical gain is about
`0.000423487` percentage points. This is a comparison of stated candidates,
not a claim of accepted priority.

## Proof status

- New scaled pressure and two-certificate supporting-plane lemmas: proved in
  `main.tex` by a complete eigenvalue case split and a piecewise-affine/
  concavity argument.
- Final comparison `> 0.673316977`: reduced to exact rational arithmetic and
  one explicit squaring in `main.tex`.
- Imported analytic and computational inputs: the arbitrary-window
  stability interface, compact-uniform Gram limit, and the upstream
  interval certificates.  This draft does not claim to have independently
  replayed the 2,168,370-node seven-point or 116,272,426-node nine-point run.
- Status: research-draft candidate pending independent review.

Run the complete local check with no third-party dependency:

```bash
python3 verify_release.py
```

This checks the manifest, the displayed constants, the exact rational
comparison, and the closed-form block-length diagnostic. It does not perform
or replace either upstream large interval run.

## Files

- `main.tex`, `main.pdf`: manuscript and compiled paper.
- `RESULT.json`: machine-readable headline value, exact rational bound, and
  pinned dependencies.
- `PROOF_OUTLINE.md`, `REVIEW_GUIDE.md`: short proof map and load-bearing
  checklist for independent readers.
- `CLAIM_LEDGER.md`: zero-trust separation of verified, imported, and open
  claims.
- `exact_check.py`: dependency-free exact-rational check and high-precision
  decimal display of the new assembly only.
- `upstream/`, `check_upstream_inputs.py`: verbatim small snapshots of the
  two candidate files and two certificate logs, plus an exact compatibility
  and Git-blob audit.
- `joint_check.py`: dependency-free scan of the closed formula over integer
  block lengths; it does not search for or certify local gap weights.
- `PROVENANCE.md`, `VERIFICATION.md`, `UPSTREAM.lock`: contribution record,
  trust boundary, replay instructions, and exact upstream pin.
- `CITATION.cff`, `LICENSE`, `NOTICE`, `CHANGELOG.md`, `MANIFEST.sha256`:
  release, third-party attribution, and integrity metadata.
- `verify_release.py`, `Makefile`, `.github/workflows/verify.yml`: one-command
  local verification and the same lightweight check in GitHub Actions.
- `pyproject.toml`, `tests/`: standard project metadata and dependency-free
  unit tests for the exact comparison and input compatibility.
- `RELEASE_CHECKLIST.md`: immutable-release, DOI, disclosure, and correction
  steps to follow before publicity.

For reproducibility, the upstream finite certificate is pinned to commit
`1610b97b7895ff34982260f8dcaf04a0f7b82cf7`; this repository intentionally
does not duplicate its large verification code or claim an independent
replay.  The public status should remain **research-draft candidate** until
the imported analytic interface and certificate have received independent
review.

The earlier paper [*A Schur--Jensen Gain in the Critical-Line Zero
Problem*](https://doi.org/10.5281/zenodo.21903013) is not combined additively
with this proof: its remainder is already bounded above by the `tr Psi`
stability defect used here, so addition would double count.
