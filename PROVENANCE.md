# Provenance and trust boundary

## New contribution

This research draft retains two already-certified local inequalities on one
common admissible window and proves a new finite-dimensional supporting-plane
deduction.  The new material consists of:

- the two-certificate supporting-plane lemma;
- the coefficientwise comparison between the seven- and nine-point span
  sums inside a common finite block;
- the shifted-block assembly at `m = 219`;
- the exact arithmetic giving
  `0.6733169771424713... > 673316977/10^9`.

No floating-point optimization, new gap weights, new window, or new large
interval run is used in this deduction.

The repository now includes a no-`sorry` Lean 4 formalization of the new
supporting-plane and exact-arithmetic layer.  The upstream certificates and
analytic interface remain explicit imported hypotheses.  Once the
trace-envelope alternative is supplied as a hypothesis, the formalized
conditional scalar step does not use the span comparison or auxiliary slope
conditions.  The spectral derivation of that alternative is not formalized
here; the coefficients and final value are unchanged.

The immutable `v0.1.0` release is permanently archived at
[Zenodo](https://doi.org/10.5281/zenodo.21926962), version DOI
`10.5281/zenodo.21926962`, from Git commit
`1469eeefe29c48c971ecf98092bc82751dea8bca`.  The deposited PDF, source ZIP,
and checksum file were checked byte for byte against the prepared release
package.

A second zero-trust pass checked the two upstream candidate files directly:
their window coefficient vectors agree, all listed pair weights are
nonnegative, and the span capacities are exactly `2`. The published logs
state `verified=True`; their large searches were not rerun here.

## Imported material

The following public repository is pinned exactly:

- `trmdy/zeta-simple-zeros-673137`, commit
  `1610b97b7895ff34982260f8dcaf04a0f7b82cf7`.

From that commit this draft imports:

- the rational seven-term window and its certified baseline
  `H_cert = 3362285207/5000000000`;
- the seven-point certificate with pressure `1/2736`, target `891/200000`,
  and exact span capacities `2`;
- the nine-point certificate with pressure `1/2500`, target
  `15211/2500000`, and exact span capacities `2`;
- the arbitrary-window stability/Gram interface as cited there.

The corresponding upstream records are:

- `certificates/retuned-p2736-grid4000.txt` (2,168,370 nodes);
- `certificates/nine-point-final-grid4000.txt` (a disjoint 96-shard cover,
  116,272,426 total nodes).

The present repository does not copy or independently replay those large
interval searches.  It therefore proves a rigorous deduction from pinned
imported certificates, not an independent recertification of them.  The
analytic interface and endpoint asymptotics are likewise cited inputs rather
than re-formalized here.

## Contribution and attribution

Yuhang Shi is the author of the present supporting-plane deduction and is
responsible for the mathematical claims and the public version.

The imported finite certificates and window are credited to the contributors
of `trmdy/zeta-simple-zeros-673137`; its finite-dimensional envelope and
window-in-frame counting trace to `tawanerguo-cn/zeta-simple-zeros`.  The
analytic framework originates in the Anthropic paper and Lean artifact, with
the stability refinement developed in `ainta/zeta-simple-zeros`.

## Status

Research-draft candidate pending independent mathematical review.  Public
release should not be described as peer reviewed or end-to-end formalized.
