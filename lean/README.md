# Lean 4 verification of the local deduction

This directory formalizes the new finite-dimensional supporting-plane
deduction and its exact numerical specialization at block length `219`.
It is deliberately not an end-to-end formalization of the imported analytic
framework or the upstream interval certificates.

## Formalized statements

- `TwoCertificate/SupportingPlane.lean` proves the abstract two-certificate
  supporting-plane theorem.  It assumes the two local certificate
  inequalities and an explicit trace-envelope alternative.
- `TwoCertificate/Phi219.lean` proves the identity, chord, and monotonicity
  bounds for the concrete piecewise function `Phi_219`, using Mathlib's
  concavity theorem for the real square root.  It then instantiates the
  supporting-plane theorem with the manuscript constants.
- `TwoCertificate/ExactConstants.lean` proves the rational constant
  identities, the strict square-root enclosure `R0 < R`, the affine pressure
  tax, and the final strict bound `> 673316977 / 10^9`.
- `Audit.lean` prints the axiom dependencies of the load-bearing theorems.

For Palomar, `Challenge.lean` restates three auditable conclusions using only
ordinary Mathlib imports, while `Solution.lean` proves the same declarations
from the substantive modules above.  `comparator.json` selects those three
declarations, and `formalization.yaml` records the precise scope, provenance,
automation, and known limitations.  This is a nested Lean project in the
larger research repository; the repository-root MIT licence covers the fixed
snapshot.

The formal proof isolates a scalar simplification: once the explicit
trace-envelope alternative is supplied, the span comparison and the two extra
slope hypotheses in the manuscript's supporting-plane lemma are unnecessary
for that scalar conclusion.  The spectral derivation of the trace-envelope
alternative is not formalized here.  The coefficients and final constant are
unchanged.

## Explicit trust boundary

The following remain hypotheses or external inputs and are not claimed to be
formalized here:

- the upstream seven- and nine-point interval certificates;
- the arbitrary-window analytic stability inequality;
- the Gram-matrix asymptotic, endpoint trimming, and global block averaging;
- the spectral case split summarized by
  `R <= D ∨ phi219 E <= D` in `concreteSupportingPlane`.

Thus this artifact machine-checks the repository's new supporting-plane and
exact-arithmetic layer, not the whole zeta-zero theorem.

## Reproduce

The toolchain and Mathlib commit are pinned in `lean-toolchain`,
`lakefile.toml`, and `lake-manifest.json`.

```bash
cd lean
lake exe cache get
lake build
lake env lean Audit.lean
```

The substantive modules and `Solution.lean` contain no `sorry`, `admit`, or
user-declared axiom.  `Challenge.lean` contains exactly three deliberate
statement holes, as required for the Comparator statement/solution split;
they are not imported by `Solution.lean`.  The audit prints only
Lean/Mathlib's standard logical axioms (`propext`, `Classical.choice`, and
`Quot.sound`) for both the underlying and wrapper theorems and does not
contain `sorryAx`.
