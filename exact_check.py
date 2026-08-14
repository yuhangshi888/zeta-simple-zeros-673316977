"""Small exact/decimal check for the constants in main.tex.

This does not replay the upstream interval certificate.  It verifies only
the new assembly constants and the stated rational comparison.
"""

from decimal import Decimal, localcontext
from fractions import Fraction as F


def main() -> None:
    m, q7, q9 = 219, 6, 8
    h = F(3_362_285_207, 5_000_000_000)
    eps7, p7 = F(891, 200_000), F(1, 2_736)
    eps9, p9 = F(15_211, 2_500_000), F(1, 2_500)
    a7 = eps7 * (m - q7)
    a9 = eps9 * (m - q9)

    # Exact checks used in the manuscript.
    assert a7 == F(189_783, 200_000)
    assert a9 == F(3_209_521, 2_500_000)
    assert a7 < F(m, m - 1) < a9
    assert a7 / p7 - F(3, 4) * a9 / p9 == F(18_909_069, 100_000)

    r0 = F(6_333_939, 5_000_000)
    square_target = (r0 + 1 - a9 / m) / 2
    square_margin = F(m - 1, m) * a9 - square_target**2
    assert square_margin == F(239_006_467_199, 4_796_100_000_000_000_000)
    assert square_margin > 0

    tax_r = F(19_769_000, 31_814_873)
    tax_c = -F(389_820_601, 3_181_487_300)
    derivative_margin = m * h - tax_c - m * tax_r
    assert derivative_margin == F(
        1_799_014_260_305_932_709, 159_074_365_000_000_000
    )
    assert derivative_margin > 0

    lower_at_r0 = (m * h - tax_r * r0 - tax_c) / (m - r0)
    assert lower_at_r0 == F(
        23_320_853_620_214_932_709, 34_635_772_470_125_253_000
    )
    comparison_margin = lower_at_r0 - F(673_316_977, 1_000_000_000)
    assert comparison_margin == F(
        4_570_374_547_679_819, 34_635_772_470_125_253_000_000_000
    )
    assert comparison_margin > 0

    # High-precision decimal display.  The strict comparison above is the
    # rigorous check; these decimals are included only for readability.
    with localcontext() as decimal_context:
        decimal_context.prec = 90

        def dec(x: F) -> Decimal:
            return Decimal(x.numerator) / Decimal(x.denominator)

        a7_dec, a9_dec = dec(a7), dec(a9)
        r_dec = (
            2 * (Decimal(m - 1) * a9_dec / Decimal(m)).sqrt()
            - 1
            + a9_dec / m
        )
        u_dec = (r_dec - a7_dec) / (a9_dec - a7_dec)
        beta_dec = (1 - u_dec) * dec(p7)
        gamma_dec = u_dec * dec(p9)
        tax_dec = (
            beta_dec * Decimal(q7 * (m - q7))
            + gamma_dec * Decimal(q9 * (m - q9))
        )
        b_dec = (Decimal(m) * dec(h) - tax_dec) / (Decimal(m) - r_dec)

    print(f"A7 = {a7}")
    print(f"A9 = {a9}")
    print(f"R = {r_dec}")
    print(f"u = {u_dec}")
    print(f"beta = {beta_dec}")
    print(f"gamma = {gamma_dec}")
    print(f"tax = {tax_dec}")
    print(f"B = {b_dec}")
    print(f"rational comparison margin = {comparison_margin}")


if __name__ == "__main__":
    main()
