# Proof outline and exact constants

The full proof is in [`main.pdf`](main.pdf). This page is a short review map,
not a substitute for the manuscript.

## Imported inputs

For the retained central simple zeros, the pinned upstream framework gives

\[
S\ge H_{\rm cert}N+\operatorname{tr}\Psi(M)-o(N),\qquad
H_{\rm cert}=\frac{3362285207}{5000000000}.
\]

On the same certified window and kernel \(w=k_v^2\), it gives two local
inequalities with

\[
(p_7,\epsilon_7)=\left(\frac1{2736},\frac{891}{200000}\right),\qquad
(p_9,\epsilon_9)=\left(\frac1{2500},\frac{15211}{2500000}\right),
\]

and every span capacity is exactly \(2\). The inputs are pinned to upstream
commit `1610b97b7895ff34982260f8dcaf04a0f7b82cf7`.

## New finite-dimensional step

For a positive-semidefinite, unit-diagonal \(m\)-by-\(m\) Gram matrix, write

\[
E=\operatorname{tr}(G-I)^2,\qquad D=\operatorname{tr}\Psi(G).
\]

The eigenvalue argument in the paper proves the relevant trace--energy
envelope

\[
\Phi_m(E)=
\begin{cases}
E,&E\le m/(m-1),\\
2\sqrt{(m-1)E/m}-1+E/m,&E\ge m/(m-1).
\end{cases}
\]

For an \(m\)-point block, let \(W_6,W_8\) be the sums of all consecutive
seven- and nine-point window spans. Summing the two local certificates gives

\[
E+p_7W_6\ge A_7,\qquad E+p_9W_8\ge A_9,
\]

and direct gap counting gives \(W_6\ge3W_8/4\).

At \(m=219\),

\[
A_7=\frac{189783}{200000}<\frac{219}{218}
<A_9=\frac{3209521}{2500000}.
\]

Put \(R=\Phi_{219}(A_9)\), \(u=(R-A_7)/(A_9-A_7)\),
\(\beta=(1-u)/2736\), and \(\gamma=u/2500\). The new supporting-plane
lemma proves

\[
D+\beta W_6+\gamma W_8\ge R.
\]

Its proof checks the affine breakpoints on \([0,A_7]\), uses concavity on
\([A_7,A_9]\), and uses monotonicity beyond \(A_9\).

## Shifted-block assembly

Pinching and averaging over all shifted \(219\)-point partitions gives

\[
\operatorname{tr}\Psi(M)\ge
\frac{R}{219}S-
\frac{6(219-6)\beta+8(219-8)\gamma}{219}N-o(N).
\]

Substitution into the imported stability interface yields

\[
\liminf_{T\to\infty}\frac SN\ge
\frac{219H_{\rm cert}-6(219-6)\beta-8(219-8)\gamma}{219-R}
=0.6733169771424713134\ldots .
\]

The strict inequality \(>673316977/10^9\) is proved in the paper by exact
rational arithmetic and one sign-controlled squaring. The decimal is not
used as proof.

## Trust boundary

This repository independently checks the new algebra and deduction. It does
not independently replay the upstream 2,168,370-node and 116,272,426-node
interval searches, nor formalize the full analytic interface in Lean. See
[`VERIFICATION.md`](VERIFICATION.md) and [`CLAIM_LEDGER.md`](CLAIM_LEDGER.md).
