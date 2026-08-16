import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith

/-!
# The two-certificate supporting-plane deduction

This file formalizes the finite-dimensional algebraic step which is new in
the accompanying manuscript.  The certificate inequalities and the trace
envelope are hypotheses: no interval-search output is imported here.
-/

namespace TwoCertificate

/-- The three scalar lower-envelope facts used by the supporting-plane
argument.  They are exactly the identity branch, the chord bound, and the
right-hand monotonicity bound. -/
structure EnvelopeProfile (phi : ℝ → ℝ) (A7 A9 R u : ℝ) : Prop where
  low : ∀ {E : ℝ}, 0 ≤ E → E ≤ A7 → E ≤ phi E
  middle : ∀ {E : ℝ}, A7 ≤ E → E ≤ A9 → A7 + u * (E - A7) ≤ phi E
  high : ∀ {E : ℝ}, A9 ≤ E → R ≤ phi E

/--
The exact two-certificate supporting-plane lemma.

The disjunction in `hTrace` records the only output needed from the spectral
case split: either the desired trace level has already been reached, or the
trace defect dominates the scalar envelope.  Notice that the proof does not
need the additional span comparison between the two pressure sums; the two
certificate inequalities themselves suffice.
-/
theorem twoCertificateSupportingPlane
    (phi : ℝ → ℝ)
    (E D L7 L9 A7 A9 R p7 p9 u beta gamma : ℝ)
    (hE : 0 ≤ E)
    (hL7 : 0 ≤ L7) (hL9 : 0 ≤ L9)
    (hp7 : 0 < p7) (hp9 : 0 < p9)
    (hu0 : 0 ≤ u) (hu1 : u ≤ 1)
    (hbeta : beta = (1 - u) * p7)
    (hgamma : gamma = u * p9)
    (hR : R = (1 - u) * A7 + u * A9)
    (hcert7 : A7 ≤ E + p7 * L7)
    (hcert9 : A9 ≤ E + p9 * L9)
    (henvelope : EnvelopeProfile phi A7 A9 R u)
    (hTrace : R ≤ D ∨ phi E ≤ D) :
    R ≤ D + beta * L7 + gamma * L9 := by
  have hbeta0 : 0 ≤ beta := by
    rw [hbeta]
    exact mul_nonneg (sub_nonneg.mpr hu1) (le_of_lt hp7)
  have hgamma0 : 0 ≤ gamma := by
    rw [hgamma]
    exact mul_nonneg hu0 (le_of_lt hp9)
  rcases hTrace with hD | hphiD
  · nlinarith [mul_nonneg hbeta0 hL7, mul_nonneg hgamma0 hL9]
  · by_cases hEA7 : E ≤ A7
    · have h7 : (1 - u) * (A7 - E) ≤ beta * L7 := by
        have hcert7' : A7 - E ≤ p7 * L7 := by linarith
        have := mul_le_mul_of_nonneg_left hcert7' (sub_nonneg.mpr hu1)
        simpa [hbeta, mul_assoc] using this
      have h9 : u * (A9 - E) ≤ gamma * L9 := by
        have hcert9' : A9 - E ≤ p9 * L9 := by linarith
        have := mul_le_mul_of_nonneg_left hcert9' hu0
        simpa [hgamma, mul_assoc] using this
      have hlow : E ≤ phi E := henvelope.low hE hEA7
      rw [hR]
      nlinarith
    · have hA7E : A7 ≤ E := le_of_not_ge hEA7
      by_cases hEA9 : E ≤ A9
      · have h9 : u * (A9 - E) ≤ gamma * L9 := by
          have hcert9' : A9 - E ≤ p9 * L9 := by linarith
          have := mul_le_mul_of_nonneg_left hcert9' hu0
          simpa [hgamma, mul_assoc] using this
        have hmid : A7 + u * (E - A7) ≤ phi E :=
          henvelope.middle hA7E hEA9
        rw [hR]
        nlinarith [mul_nonneg hbeta0 hL7]
      · have hA9E : A9 ≤ E := le_of_not_ge hEA9
        have hhigh : R ≤ phi E := henvelope.high hA9E
        nlinarith [mul_nonneg hbeta0 hL7, mul_nonneg hgamma0 hL9]

end TwoCertificate
