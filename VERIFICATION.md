# Verification guide

This repository has a small local verification surface because it introduces
no new interval certificate.

## Fast local checks

Python 3.10 or newer is sufficient; no third-party package is required.

```bash
python3 verify_release.py
```

This first checks every file listed in `MANIFEST.sha256`, then runs
`check_upstream_inputs.py`, `exact_check.py`, and `joint_check.py`.
`check_upstream_inputs.py` verifies the candidate snapshots' Git blob
identities, common window, nonnegative exact weights, exact capacity sums,
and log metadata. `make verify` is an equivalent
convenience command. The committed GitHub Actions workflow runs the same
check after publication.

`exact_check.py` verifies the exact rational identities used in the strict
comparison, including the one squaring that proves the rational lower
enclosure for `R`.  Its long decimal output is for readability only.

The shorter standard-library test suite is available as

```bash
python3 -m unittest discover -s tests
```

`joint_check.py` evaluates the explicit closed formula over integer block
lengths and reports `m = 219`.  It does not search for local gap weights or
replace either upstream interval certificate.

## Lean 4 check of the local proof layer

The Lean toolchain and exact Mathlib revision are pinned under `lean/`.

```bash
cd lean
lake exe cache get
lake build
lake env lean Audit.lean
```

This checks the abstract and concrete supporting-plane theorems, the
`Phi_219` chord profile, the radical comparison, the affine tax identity, and
the final strict lower bound.  `Audit.lean` reports no `sorryAx` dependency.
The imported interval certificates and analytic zeta-function interface are
outside this formalization; see `lean/README.md` for the exact boundary.

## Compile the manuscript

The source is `main.tex`; a standard LaTeX installation or Tectonic can
compile it.  The checked PDF is committed as `main.pdf`.

The immutable `v0.1.0` paper and source package are also archived under
[Zenodo DOI 10.5281/zenodo.21926962](https://doi.org/10.5281/zenodo.21926962).
The Zenodo file checksums were compared with the local deposit package.

## Imported certificate audit

To replay the finite certificates themselves, check out exactly
`trmdy/zeta-simple-zeros-673137` at commit
`1610b97b7895ff34982260f8dcaf04a0f7b82cf7` and follow that repository's
`docs/verifier.md`.  Its verifier pins `python-flint==0.9.0` and records table
hashes and fail-closed exhaustive-subdivision runs.

The relevant upstream files are:

- `data/candidate-retuned-p2736.json`;
- `certificates/retuned-p2736-grid4000.txt`;
- `data/candidate-nine-point-final.json`;
- `src/zeta_ext/nine_point.py`;
- `certificates/nine-point-final-grid4000.txt`.

The JSON file for the final nine-point candidate contains a stale discovery-
stage field `interval_certificate_needed: true`; the later module,
certificate record, documentation, and commit history record the completed
cross-host certification.  This discrepancy is disclosed rather than
silently normalized.

The two candidate JSON files at the pinned upstream commit have identical
seven-term window coefficients. Their pair weights are nonnegative and their
declared span capacities are all exactly `2`; the certificate records report
`verified=True`. These source-level checks establish compatibility of the
inputs, but they are not an independent replay of the interval searches.

## Trust base

- the proof in `main.tex` and ordinary exact rational arithmetic;
- Lean 4, the pinned Mathlib revision, and its standard logical axioms for the
  machine-checked local layer;
- the Python interpreter for the convenience checks;
- the pinned upstream analytic interface and two finite certificates;
- the upstream Arb/FLINT verifier, operating system, and hardware for any
  independent replay of those certificates.

No sampled floating-point optimization is a premise of the stated bound.
