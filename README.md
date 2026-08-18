# Two-certificate trace--energy deduction

[![Verification](https://github.com/yuhangshi888/zeta-simple-zeros-673316977/actions/workflows/verify.yml/badge.svg?branch=main)](https://github.com/yuhangshi888/zeta-simple-zeros-673316977/actions/workflows/verify.yml)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.21926962.svg)](https://doi.org/10.5281/zenodo.21926962)
[![Release](https://img.shields.io/github/v/release/yuhangshi888/zeta-simple-zeros-673316977?label=release)](https://github.com/yuhangshi888/zeta-simple-zeros-673316977/releases/tag/v0.1.0)
[![ORCID](https://img.shields.io/badge/ORCID-0009--0006--3180--4767-A6CE39?logo=orcid&logoColor=white)](https://orcid.org/0009-0006-3180-4767)

This directory contains a short research draft giving the candidate lower
bound

```math
\liminf_{T\to\infty}\frac{N_0^s(T,2T)}{N(T,2T)}
\ge 0.6733169771424713\ldots>0.673316977.
```

The new step is purely finite-dimensional: the certified seven- and
nine-point gap inequalities are retained simultaneously and absorbed by a
supporting plane of `Phi_m`.  It reuses, without modification, the certified
window and both local inequalities from
[`trmdy/zeta-simple-zeros-673137`](https://github.com/trmdy/zeta-simple-zeros-673137)
at commit `1610b97b7895ff34982260f8dcaf04a0f7b82cf7`.

**[Paper](main.pdf)** · **[Permanent archive](https://doi.org/10.5281/zenodo.21926962)** ·
**[Proof outline](PROOF_OUTLINE.md)** ·
**[Exact result](RESULT.json)** · **[Independent review guide](REVIEW_GUIDE.md)** ·
**[Lean 4 verification](lean/README.md)** ·
**[Submit a verification report](https://github.com/yuhangshi888/zeta-simple-zeros-673316977/issues/new?template=verification-report.yml)**

Version record: `v0.1.0` is fixed at commit
[`1469eeefe29c48c971ecf98092bc82751dea8bca`](https://github.com/yuhangshi888/zeta-simple-zeros-673316977/commit/1469eeefe29c48c971ecf98092bc82751dea8bca)
and permanently archived as [Zenodo DOI 10.5281/zenodo.21926962](https://doi.org/10.5281/zenodo.21926962).

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
- The new supporting-plane deduction, the concrete `Phi_219` chord profile,
  and the exact final comparison are machine-checked in Lean 4 with no
  `sorry`.  The formal theorem is slightly stronger than the manuscript
  lemma: its span-comparison and extra slope hypotheses are not needed.
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

The independent Lean check is:

```bash
cd lean
lake exe cache get
lake build
lake env lean Audit.lean
```

Its trust boundary is stated precisely in [`lean/README.md`](lean/README.md).

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
- `assets/social-preview.png`, `assets/social-preview.svg`: restrained social
  preview artwork with an editable source, sized for GitHub link cards.
- `verify_release.py`, `Makefile`, `.github/workflows/verify.yml`: one-command
  local verification, Lean build, and corresponding GitHub Actions checks.
- `lean/`: pinned Lean 4/Mathlib sources for the supporting-plane theorem,
  the concrete `Phi_219` profile, and the exact final comparison.
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

## Citation

Shi, Y. (2026). *A two-certificate trace-energy deduction for simple zeros
of the Riemann zeta function* (Version 0.1.0). Zenodo.
[https://doi.org/10.5281/zenodo.21926962](https://doi.org/10.5281/zenodo.21926962)

The archived manuscript is available under CC BY 4.0.  The repository code
remains available under the MIT license in `LICENSE`.

```bibtex
@misc{Shi2026TwoCertificate,
  author    = {Yuhang Shi},
  title     = {A two-certificate trace-energy deduction for simple zeros of
               the Riemann zeta function},
  year      = {2026},
  version   = {0.1.0},
  publisher = {Zenodo},
  doi       = {10.5281/zenodo.21926962},
  url       = {https://doi.org/10.5281/zenodo.21926962}
}
```

The earlier paper [*A Schur--Jensen Gain in the Critical-Line Zero
Problem*](https://doi.org/10.5281/zenodo.21903013) is not combined additively
with this proof: its remainder is already bounded above by the `tr Psi`
stability defect used here, so addition would double count.
