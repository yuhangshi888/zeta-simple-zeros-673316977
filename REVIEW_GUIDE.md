# Independent review guide

Reports may be submitted through the structured
[verification-report form](https://github.com/yuhangshi888/zeta-simple-zeros-673316977/issues/new?template=verification-report.yml).
Corrections and negative findings are as useful as confirmations.

The fastest useful review is to check the following points in order.

1. **Imported data.** At upstream commit
   `1610b97b7895ff34982260f8dcaf04a0f7b82cf7`, verify that the seven- and
   nine-point candidates use the same window coefficients and kernel, have
   nonnegative rational pair weights, and have every span capacity exactly
   `2`. Compare the two certificate logs with `UPSTREAM.lock`.
2. **Supporting plane.** Check Lemma 2.2 of `main.pdf`, especially the
   active affine branch on `[0,A_7]`, the slope inequality, and concavity on
   `[A_7,A_9]`.
3. **Span comparison.** Check coefficientwise that every block gap has
   multiplicity ratio at least `6/8`, giving `W_6 >= 3 W_8/4`, including at
   both endpoints.
4. **Uniformity.** Check the pressure-versus-bounded-span case split used
   before invoking the compact-uniform Gram asymptotic.
5. **Global accounting.** Check the shifted-partition factors `m-q`, the
   window-span bound by `q` times the total span, and the endpoint `o(N)`
   terms.
6. **Exact arithmetic.** Run `python3 verify_release.py`; then compare its
   displayed constants with Theorem 1.1 and the final rational comparison in
   `main.pdf`.

Please report separately whether a concern affects a new local deduction, an
imported certificate, or the imported analytic interface. The public status
is deliberately “research-draft candidate pending independent review.”
