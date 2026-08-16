import Mathlib.Analysis.Real.Sqrt
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

/-!
# Exact constants in the 67.3316977% deduction

All decimal claims used in the final comparison are replaced here by exact
rational identities and one rigorously checked square-root comparison.
-/

namespace TwoCertificate.Exact

noncomputable section

def A7 : ℝ := 189783 / 200000
def A9 : ℝ := 3209521 / 2500000
def H : ℝ := 3362285207 / 5000000000
def R0 : ℝ := 6333939 / 5000000
def radicand : ℝ := 349837789 / 273750000
def R : ℝ := 2 * Real.sqrt radicand - 1 + A9 / 219
def u : ℝ := (R - A7) / (A9 - A7)
def beta : ℝ := (1 - u) / 2736
def gamma : ℝ := u / 2500
def taxSlope : ℝ := 19769000 / 31814873
def taxConstant : ℝ := -(389820601 / 3181487300)
def target : ℝ := 673316977 / 1000000000

theorem threshold_order : A7 < 219 / 218 ∧ 219 / 218 < A9 := by
  norm_num [A7, A9]

theorem pressure_separation :
    A7 / (1 / 2736 : ℝ) - (3 / 4 : ℝ) * A9 / (1 / 2500 : ℝ) =
      18909069 / 100000 := by
  norm_num [A7, A9]

theorem square_margin :
    radicand - ((R0 + 1 - A9 / 219) / 2) ^ 2 =
      239006467199 / 4796100000000000000 := by
  norm_num [radicand, R0, A9]

theorem R0_lt_R : R0 < R := by
  have hx : 0 ≤ radicand := by norm_num [radicand]
  have hs : 0 ≤ (R0 + 1 - A9 / 219) / 2 := by
    norm_num [R0, A9]
  have hm : ((R0 + 1 - A9 / 219) / 2) ^ 2 < radicand := by
    have hpos : 0 < radicand - ((R0 + 1 - A9 / 219) / 2) ^ 2 := by
      rw [square_margin]
      norm_num
    linarith
  have hsqrt : (Real.sqrt radicand) ^ 2 = radicand := Real.sq_sqrt hx
  have hlt : (R0 + 1 - A9 / 219) / 2 < Real.sqrt radicand := by
    nlinarith [Real.sqrt_nonneg radicand]
  unfold R
  linarith

theorem R_lt_A9 : R < A9 := by
  have hx : 0 ≤ radicand := by norm_num [radicand]
  have hx1 : 1 < radicand := by norm_num [radicand]
  have hsqrt : (Real.sqrt radicand) ^ 2 = radicand := Real.sq_sqrt hx
  have hsqrt1 : 1 < Real.sqrt radicand := by
    nlinarith [Real.sqrt_nonneg radicand]
  have hrelation : radicand = (218 / 219 : ℝ) * A9 := by
    norm_num [radicand, A9]
  unfold R
  nlinarith [hrelation, sq_pos_of_pos (sub_pos.mpr hsqrt1)]

theorem A7_lt_R : A7 < R := by
  have hA7R0 : A7 < R0 := by norm_num [A7, R0]
  exact hA7R0.trans R0_lt_R

theorem u_strict : 0 < u ∧ u < 1 := by
  have hden : 0 < A9 - A7 := sub_pos.mpr (A7_lt_R.trans R_lt_A9)
  constructor
  · exact div_pos (sub_pos.mpr A7_lt_R) hden
  · change (R - A7) / (A9 - A7) < 1
    rw [div_lt_one hden]
    linarith [R_lt_A9]

theorem R_barycentric : R = (1 - u) * A7 + u * A9 := by
  have hne : A9 - A7 ≠ 0 := ne_of_gt (sub_pos.mpr (A7_lt_R.trans R_lt_A9))
  rw [u]
  field_simp
  ring

theorem tax_affine :
    beta * 6 * (219 - 6) + gamma * 8 * (219 - 8) =
      taxSlope * R + taxConstant := by
  norm_num [beta, gamma, u, taxSlope, taxConstant, A7, A9]
  ring

theorem derivative_margin :
    219 * H - taxConstant - 219 * taxSlope =
      1799014260305932709 / 159074365000000000 := by
  norm_num [H, taxConstant, taxSlope]

theorem comparison_at_R0 :
    (219 * H - taxSlope * R0 - taxConstant) / (219 - R0) - target =
      4570374547679819 / 34635772470125253000000000 := by
  norm_num [H, taxSlope, taxConstant, R0, target]

/-- The exact final lower-bound comparison, with no decimal rounding. -/
theorem final_strict_bound :
    target < (219 * H - (beta * 6 * (219 - 6) + gamma * 8 * (219 - 8))) /
      (219 - R) := by
  rw [tax_affine]
  have hR219 : R < 219 := lt_trans R_lt_A9 (by norm_num [A9])
  have hR0219 : R0 < 219 := by norm_num [R0]
  have hmargin : 0 < 219 * H - taxConstant - 219 * taxSlope := by
    rw [derivative_margin]
    norm_num
  have hmono :
      (219 * H - taxSlope * R0 - taxConstant) / (219 - R0) <
        (219 * H - taxSlope * R - taxConstant) / (219 - R) := by
    rw [div_lt_div_iff₀ (sub_pos.mpr hR0219) (sub_pos.mpr hR219)]
    nlinarith [mul_pos (sub_pos.mpr R0_lt_R) hmargin]
  have hbase :
      target < (219 * H - taxSlope * R0 - taxConstant) / (219 - R0) := by
    have hpos :
        0 < (219 * H - taxSlope * R0 - taxConstant) / (219 - R0) - target := by
      rw [comparison_at_R0]
      norm_num
    linarith
  have hrearrange :
      219 * H - (taxSlope * R + taxConstant) =
        219 * H - taxSlope * R - taxConstant := by ring
  rw [hrearrange]
  exact hbase.trans hmono

end

end TwoCertificate.Exact
