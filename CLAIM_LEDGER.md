# Zero-trust claim ledger

Audit date: 2026-08-16.

## Verified in this draft

1. **Scaled pressure lemma.**  For a positive-semidefinite unit-diagonal
   `m x m` matrix, if `E+P >= A`, `A >= m/(m-1)`, and `Phi_m(A)<2`, then
   `tr Psi(G) + (Phi_m(A)/A) P >= Phi_m(A)`.  The proof treats separately
   zero, one, and at least two eigenvalue displacements above `1`.
2. **Concavity and chord.**  `Phi_m` is increasing, `C^1`, and concave; hence
   `Phi_m(E) >= E Phi_m(A)/A` for `0 <= E <= A`.
3. **Two-certificate supporting plane.**  The simultaneous seven- and
   nine-point block inequalities, together with `W_6 >= 3 W_8/4`, imply the
   stated supporting-plane bound.  The proof checks every affine breakpoint
   and uses concavity only on `[A_7,A_9]`.
4. **Window counting.**  In the average over `m` shifted consecutive-block
   partitions, a `(q+1)`-point window is contained in at most `m-q` full
   blocks; every gap occurs in at most `q` such windows.  Coefficientwise,
   `W_6 >= 3 W_8/4` also holds, including at block endpoints.
5. **Exact constants.**  At `m=219`,
   `A_7=189783/200000`, `A_9=3209521/2500000`, and
   `Phi_219(A_9)=1.2667878440823898...`.  The assembled expression equals
   `0.6733169771424713...`; the strict bound `>673316977/10^9` is proved by
   exact rational comparisons recorded in `main.tex`.
6. **No double counting with the prior Schur--Jensen paper.**  Since
   `Psi=g+1`, direct subtraction gives
   `tr Psi(M)-S_g=sum_j(1-M_jj)^2 >= 0`; there is equality at unit diagonal.
7. **Source-level compatibility.** Direct inspection at the pinned upstream
   commit shows that the two candidate files use the identical window
   coefficient vector, list nonnegative rational pair weights, and declare
   every span capacity exactly `2`. Their logs state `verified=True`.
8. **Lean-checked local layer.**  Lean 4 verifies, with no `sorry`, the
   two-certificate supporting-plane theorem, the identity/chord/monotonicity
   profile of the explicit `Phi_219`, the exact radical enclosure, the
   affine pressure tax, and the final strict rational comparison.  The
   certificate inequalities and the trace-envelope alternative are explicit
   theorem hypotheses, not hidden axioms.

## Cited/imported, not independently reproved here

1. The arbitrary-window stability interface
   `S >= H_cert N + tr Psi(M) - o(N)`.
2. The compact-uniform Gram-entry asymptotic and endpoint trimming.
3. Convex spectral pinching for `tr Psi`.
4. The certified window baseline
   `H_cert=3362285207/5000000000`.
5. The seven-point inequality with pressure `1/2736`, target `891/200000`,
   and all six span capacities equal to `2`; its public certificate reports
   2,168,370 nodes.
6. The final nine-point inequality with pressure `1/2500`, target
   `15211/2500000`, and all eight span capacities equal to `2`; its public
   certificate reports a disjoint 96-shard cover with 116,272,426 nodes.
   Neither full interval run was replayed in this audit.

## Quarantined/open

1. A second upstream certificate at pressure `13/50000` reports target
   `8727/2000000`, but its exact 36 weights were not committed.  It cannot be
   combined with the final certificate rigorously from the public record.
2. No claim is made that `m=219` is globally optimal over all possible new
   methods.  The dependency-free script scans the explicit closed formula
   through `m=100000`; a separate local audit extended the same formula to
   `m=1000000`.  These are finite diagnostics, not a variational theorem.
3. Adding the older certified seven-point operating point (`p=1/2300`,
   target `1/200`) to the supporting-plane knots gives a lower value in the
   corresponding finite diagnostic; it is therefore not used.
4. GitHub code search and a general web search performed on 2026-08-14 found
   no occurrence of the
   `0.673316977` value or the two-certificate formula, but such a search cannot
   establish priority conclusively.
5. The upstream log at pressure `13/50000` and target `8727/2000000` has no
   accompanying committed weight table. Commit history adds only the log,
   so the attractive three-certificate numerical reconstruction remains
   quarantined and is not part of the theorem.

## Correction recorded during this audit

An earlier proof sentence said that the supporting-plane lower bound had
value `R` at both `E=0` and `E=A_7`. The exact proof only needs, and gives,
equality at `E=0` and a value at least `R` at `E=A_7`; the following
concavity argument then applies. The manuscript wording has been corrected.
The lemma, constants, and final lower bound are unchanged.

## Simplification found by formalization

The formal proof shows that `W_6 >= 3 W_8/4`,
`A_7/p_7 >= 3A_9/(4p_9)`, and the extra slope inequality are not needed for
the supporting-plane conclusion.  On `[0,A_7]` one combines both certificate
bounds; on `[A_7,A_9]` the nine-point bound alone pays the gap from the chord
of `Phi_219`; and on `[A_9,infinity)` the envelope itself reaches `R`.
The manuscript theorem remains valid as stated, and its coefficients and
numerical result are unchanged.
