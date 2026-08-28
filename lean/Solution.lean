import TwoCertificate

/-!
# Proved Palomar solution

Comparator checks that the declarations below have exactly the same types as
the declarations in `Challenge.lean`.  Their proofs are wrappers around the
substantive zero-`sorry` development in `TwoCertificate/`.
-/

namespace TwoCertificatePalomar

theorem two_certificate_supporting_plane
    (phi : ℝ → ℝ)
    (E D L7 L9 A7 A9 R p7 p9 u : ℝ)
    (hE : 0 ≤ E)
    (hL7 : 0 ≤ L7) (hL9 : 0 ≤ L9)
    (hp7 : 0 < p7) (hp9 : 0 < p9)
    (hu0 : 0 ≤ u) (hu1 : u ≤ 1)
    (hR : R = (1 - u) * A7 + u * A9)
    (hcert7 : A7 ≤ E + p7 * L7)
    (hcert9 : A9 ≤ E + p9 * L9)
    (hlow : ∀ {x : ℝ}, 0 ≤ x → x ≤ A7 → x ≤ phi x)
    (hmiddle : ∀ {x : ℝ}, A7 ≤ x → x ≤ A9 →
      A7 + u * (x - A7) ≤ phi x)
    (hhigh : ∀ {x : ℝ}, A9 ≤ x → R ≤ phi x)
    (hTrace : R ≤ D ∨ phi E ≤ D) :
    R ≤ D + ((1 - u) * p7) * L7 + (u * p9) * L9 := by
  exact TwoCertificate.twoCertificateSupportingPlane
    phi E D L7 L9 A7 A9 R p7 p9 u ((1 - u) * p7) (u * p9)
    hE hL7 hL9 hp7 hp9 hu0 hu1 rfl rfl hR hcert7 hcert9
    ⟨hlow, hmiddle, hhigh⟩ hTrace

theorem phi219_supporting_plane :
    let A7 : ℝ := 189783 / 200000
    let A9 : ℝ := 3209521 / 2500000
    let radicand : ℝ := 349837789 / 273750000
    let R : ℝ := 2 * Real.sqrt radicand - 1 + A9 / 219
    let u : ℝ := (R - A7) / (A9 - A7)
    let beta : ℝ := (1 - u) / 2736
    let gamma : ℝ := u / 2500
    let phi219 : ℝ → ℝ := fun x ↦
      if x ≤ 219 / 218 then x
      else 2 * Real.sqrt ((218 / 219) * x) - 1 + x / 219
    ∀ (E D L7 L9 : ℝ),
      0 ≤ E → 0 ≤ L7 → 0 ≤ L9 →
      A7 ≤ E + (1 / 2736) * L7 →
      A9 ≤ E + (1 / 2500) * L9 →
      (R ≤ D ∨ phi219 E ≤ D) →
      R ≤ D + beta * L7 + gamma * L9 := by
  dsimp
  intro E D L7 L9 hE hL7 hL9 hcert7 hcert9 hTrace
  have h := TwoCertificate.Exact.concreteSupportingPlane
    E D L7 L9 hE hL7 hL9
    (by simpa only [TwoCertificate.Exact.A7] using hcert7)
    (by simpa only [TwoCertificate.Exact.A9] using hcert9)
    (by
      rcases hTrace with hR | hphi
      · left
        simpa only [TwoCertificate.Exact.R, TwoCertificate.Exact.radicand,
          TwoCertificate.Exact.A9] using hR
      · right
        dsimp [TwoCertificate.Exact.phi219,
          TwoCertificate.Exact.threshold, TwoCertificate.Exact.scale]
        convert hphi using 1
        all_goals norm_num)
  simpa only [TwoCertificate.Exact.R, TwoCertificate.Exact.radicand,
    TwoCertificate.Exact.A7, TwoCertificate.Exact.A9,
    TwoCertificate.Exact.u, TwoCertificate.Exact.beta,
    TwoCertificate.Exact.gamma] using h

theorem exact_final_comparison :
    let A7 : ℝ := 189783 / 200000
    let A9 : ℝ := 3209521 / 2500000
    let H : ℝ := 3362285207 / 5000000000
    let radicand : ℝ := 349837789 / 273750000
    let R : ℝ := 2 * Real.sqrt radicand - 1 + A9 / 219
    let u : ℝ := (R - A7) / (A9 - A7)
    let beta : ℝ := (1 - u) / 2736
    let gamma : ℝ := u / 2500
    (673316977 / 1000000000 : ℝ) <
      (219 * H - (beta * 6 * (219 - 6) + gamma * 8 * (219 - 8))) /
        (219 - R) := by
  simpa [TwoCertificate.Exact.A7, TwoCertificate.Exact.A9,
    TwoCertificate.Exact.H, TwoCertificate.Exact.radicand,
    TwoCertificate.Exact.R, TwoCertificate.Exact.u,
    TwoCertificate.Exact.beta, TwoCertificate.Exact.gamma,
    TwoCertificate.Exact.target] using
      TwoCertificate.Exact.final_strict_bound

end TwoCertificatePalomar
