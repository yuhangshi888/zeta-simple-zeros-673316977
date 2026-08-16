import Mathlib.Analysis.Convex.SpecificFunctions.Pow
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import TwoCertificate.SupportingPlane
import TwoCertificate.ExactConstants

/-!
# The concrete scalar envelope at block length 219

This file closes the abstract hypothesis `EnvelopeProfile` for the explicit
piecewise function used in the manuscript.  The only analytic library fact
used in the middle interval is concavity of the real square root.
-/

namespace TwoCertificate.Exact

noncomputable section

def threshold : ℝ := 219 / 218
def scale : ℝ := 218 / 219

def phi219 (E : ℝ) : ℝ :=
  if E ≤ threshold then E
  else 2 * Real.sqrt (scale * E) - 1 + E / 219

theorem radicand_eq : radicand = scale * A9 := by
  norm_num [radicand, scale, A9]

theorem phi219_A9 : phi219 A9 = R := by
  have hbranch : ¬ A9 ≤ threshold := not_le.mpr threshold_order.2
  simp only [phi219, if_neg hbranch]
  rw [R, radicand_eq]

/-- The exact identity/chord/monotonicity profile required by the abstract
two-certificate theorem. -/
theorem phi219_profile :
    TwoCertificate.EnvelopeProfile phi219 A7 A9 R u := by
  constructor
  · intro E hE hEA7
    have hEth : E ≤ threshold := hEA7.trans (le_of_lt threshold_order.1)
    simp [phi219, hEth]
  · intro E hA7E hEA9
    rcases u_strict with ⟨hu0, hu1⟩
    have hu0' : 0 ≤ u := le_of_lt hu0
    have hu1' : u ≤ 1 := le_of_lt hu1
    by_cases hEth : E ≤ threshold
    · simp only [phi219, if_pos hEth]
      nlinarith [mul_nonneg (sub_nonneg.mpr hu1') (sub_nonneg.mpr hA7E)]
    · have hthE : threshold ≤ E := le_of_not_ge hEth
      have hden : 0 < A9 - threshold := sub_pos.mpr threshold_order.2
      let a : ℝ := (A9 - E) / (A9 - threshold)
      let b : ℝ := (E - threshold) / (A9 - threshold)
      have ha : 0 ≤ a := div_nonneg (sub_nonneg.mpr hEA9) (le_of_lt hden)
      have hb : 0 ≤ b := div_nonneg (sub_nonneg.mpr hthE) (le_of_lt hden)
      have hab : a + b = 1 := by
        dsimp [a, b]
        field_simp
        ring
      have hone : (1 : ℝ) ∈ Set.Ici (0 : ℝ) := by norm_num
      have hrad : radicand ∈ Set.Ici (0 : ℝ) := by
        norm_num [radicand]
      have hjensen :=
        Real.strictConcaveOn_sqrt.concaveOn.2 hone hrad ha hb hab
      have harg : a * 1 + b * radicand = scale * E := by
        dsimp [a, b]
        norm_num [radicand, scale, A9, threshold]
        ring
      have hsqrt :
          a * Real.sqrt 1 + b * Real.sqrt radicand ≤
            Real.sqrt (scale * E) := by
        simpa only [smul_eq_mul, harg] using hjensen
      have hcombo : a * threshold + b * A9 = E := by
        dsimp [a, b]
        field_simp
        ring
      have hlineR : R = A7 + u * (A9 - A7) := by
        rw [R_barycentric]
        ring
      have hsecondChord :
          a * threshold + b * R ≤
            2 * Real.sqrt (scale * E) - 1 + E / 219 := by
        have hthresholdIdentity :
            2 * Real.sqrt 1 - 1 + threshold / 219 = threshold := by
          norm_num [threshold]
        have hRidentity :
            R = 2 * Real.sqrt radicand - 1 + A9 / 219 := by rfl
        nlinarith
      have hglobalChord :
          A7 + u * (E - A7) ≤ a * threshold + b * R := by
        have hthA7 : 0 ≤ threshold - A7 :=
          sub_nonneg.mpr (le_of_lt threshold_order.1)
        have hnonneg : 0 ≤ a * (1 - u) * (threshold - A7) :=
          mul_nonneg (mul_nonneg ha (sub_nonneg.mpr hu1')) hthA7
        have hbexpr : b = 1 - a := by linarith [hab]
        have hid :
            (a * threshold + b * R) - (A7 + u * (E - A7)) =
              a * (1 - u) * (threshold - A7) := by
          rw [← hcombo, hlineR, hbexpr]
          ring
        linarith
      simp only [phi219, if_neg hEth]
      exact hglobalChord.trans (hsecondChord)
  · intro E hA9E
    have hbranch : ¬ E ≤ threshold :=
      not_le.mpr (threshold_order.2.trans_le hA9E)
    have hscale : 0 < scale := by norm_num [scale]
    have hsqrt : Real.sqrt (scale * A9) ≤ Real.sqrt (scale * E) :=
      Real.sqrt_le_sqrt (mul_le_mul_of_nonneg_left hA9E (le_of_lt hscale))
    simp only [phi219, if_neg hbranch]
    rw [R, radicand_eq]
    nlinarith

/-- Concrete form of the supporting-plane inequality at `m = 219`.
The two certificate bounds and the trace-envelope alternative remain explicit
hypotheses, matching the repository trust boundary. -/
theorem concreteSupportingPlane
    (E D L7 L9 : ℝ)
    (hE : 0 ≤ E) (hL7 : 0 ≤ L7) (hL9 : 0 ≤ L9)
    (hcert7 : A7 ≤ E + (1 / 2736 : ℝ) * L7)
    (hcert9 : A9 ≤ E + (1 / 2500 : ℝ) * L9)
    (hTrace : R ≤ D ∨ phi219 E ≤ D) :
    R ≤ D + beta * L7 + gamma * L9 := by
  apply TwoCertificate.twoCertificateSupportingPlane
      phi219 E D L7 L9 A7 A9 R (1 / 2736) (1 / 2500) u beta gamma
  · exact hE
  · exact hL7
  · exact hL9
  · norm_num
  · norm_num
  · exact le_of_lt u_strict.1
  · exact le_of_lt u_strict.2
  · rw [beta]
    ring
  · rw [gamma]
    ring
  · exact R_barycentric
  · exact hcert7
  · exact hcert9
  · exact phi219_profile
  · exact hTrace

end

end TwoCertificate.Exact
