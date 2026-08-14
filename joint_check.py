"""Light exact/high-precision audit of the two-certificate deduction.

The scan evaluates closed formulas at integer block lengths.  It performs no
optimization of a gap certificate and does not replay any upstream interval
run.  Exact rational assertions certify the algebraic side conditions; the
Decimal scan is used only to locate and display the best integer parameter.
"""

from decimal import Decimal, localcontext
from fractions import Fraction as F


H = F(3_362_285_207, 5_000_000_000)
EPS7 = F(891, 200_000)
P7 = F(1, 2_736)
Q7 = 6
EPS9 = F(15_211, 2_500_000)
P9 = F(1, 2_500)
Q9 = 8


def dec(x: F) -> Decimal:
    return Decimal(x.numerator) / Decimal(x.denominator)


def phi(m: int, a: Decimal) -> Decimal:
    threshold = Decimal(m) / Decimal(m - 1)
    if a <= threshold:
        return a
    return 2 * (Decimal(m - 1) * a / Decimal(m)).sqrt() - 1 + a / m


def candidate(m: int):
    a7q = EPS7 * (m - Q7)
    a9q = EPS9 * (m - Q9)
    a7, a9 = dec(a7q), dec(a9q)
    threshold = Decimal(m) / Decimal(m - 1)
    r = phi(m, a9)
    if not (a7 <= threshold < a9 and r < 2 and a7 < r < a9):
        return None

    # Let L7 and L9 be the seven- and nine-point pressure sums.  The
    # pointwise comparison L7 >= 3 L9 / 4 has two elementary proofs: each
    # nine-point span is the sum of three consecutive seven-point spans, and
    # every seven-point span occurs in at most four of those triples.
    e_star_q = (
        a7q / P7 - F(3, 4) * a9q / P9
    ) / (1 / P7 - F(3, 4) / P9)
    if not (0 <= e_star_q < a7q):
        return None
    e_star = dec(e_star_q)
    phi_star = phi(m, e_star)

    # Choose beta,gamma so that the two endpoint constraints
    #   beta*A7/p7 + gamma*A9/p9 = R,
    #   (3 beta/4 + gamma)*(A9-E*)/p9 = R-Phi(E*)
    # are equalities.  Convexity/concavity then proves the full block
    # inequality; see main.tex.
    l70 = a7 / dec(P7)
    l90 = a9 / dec(P9)
    l9s = (a9 - e_star) / dec(P9)
    determinant = l70 * l9s - l90 * Decimal(3) * l9s / Decimal(4)
    beta = (r * l9s - l90 * (r - phi_star)) / determinant
    gamma = (l70 * (r - phi_star) - Decimal(3) * l9s * r / Decimal(4)) / determinant
    if beta < 0 or gamma < 0:
        return None
    u = (r - a7) / (a9 - a7)
    assert abs(beta - (1 - u) * dec(P7)) < Decimal("1e-90")
    assert abs(gamma - u * dec(P9)) < Decimal("1e-90")
    tax = beta * Q7 * (m - Q7) + gamma * Q9 * (m - Q9)
    bound = (Decimal(m) * dec(H) - tax) / (Decimal(m) - r)
    return bound, r, beta, gamma, e_star_q, a7q, a9q, tax


def main() -> None:
    with localcontext() as decimal_context:
        decimal_context.prec = 100
        rows = [(candidate(m), m) for m in range(9, 100_001)]
        rows = [(x, m) for x, m in rows if x is not None]
        (best, m) = max(rows, key=lambda row: row[0][0])
        bound, r, beta, gamma, e_star_q, a7q, a9q, tax = best

        # Structural identities used in the joint lemma.
        assert beta > 0 and gamma > 0
        l70 = dec(a7q / P7)
        l90 = dec(a9q / P9)
        l9s = dec((a9q - e_star_q) / P9)
        assert abs(beta * l70 + gamma * l90 - r) < Decimal("1e-90")
        assert abs(
            (Decimal(3) * beta / Decimal(4) + gamma) * l9s
            - (r - phi(m, dec(e_star_q)))
        ) < Decimal("1e-90")

        # Exact side conditions at the winning integer.
        assert e_star_q < F(m, m - 1)
        assert a7q < F(m, m - 1) < a9q

        print(f"best m = {m}")
        print(f"A7 = {a7q} = {dec(a7q)}")
        print(f"A9 = {a9q} = {dec(a9q)}")
        print(f"E* = {e_star_q} = {dec(e_star_q)}")
        print(f"R = {r}")
        print(f"beta = {beta}")
        print(f"gamma = {gamma}")
        print(f"tax = {tax}")
        print(f"B = {bound}")
        for mm in range(m - 4, m + 5):
            row = candidate(mm)
            if row is not None:
                print(f"m={mm}: {row[0]}")


if __name__ == "__main__":
    main()
