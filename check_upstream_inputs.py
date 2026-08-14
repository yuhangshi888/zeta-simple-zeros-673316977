"""Exact structural audit of the pinned upstream candidate snapshots."""

from __future__ import annotations

import hashlib
import json
from fractions import Fraction as F
from pathlib import Path


ROOT = Path(__file__).resolve().parent
UPSTREAM = ROOT / "upstream"


def git_blob_sha(path: Path) -> str:
    payload = path.read_bytes()
    header = f"blob {len(payload)}\0".encode()
    return hashlib.sha1(header + payload).hexdigest()


def load(name: str) -> dict:
    return json.loads((UPSTREAM / name).read_text(encoding="utf-8"))


def fraction(item: dict) -> F:
    return F(item["numerator"], item["denominator"])


def audit_candidate(data: dict, expected_s: int, expected_p: F, expected_eps: F) -> None:
    q = expected_s - 1
    assert data["s"] == expected_s
    assert fraction(data["pressure"]) == expected_p
    assert fraction(data["target_epsilon"]) == expected_eps
    order = [tuple(pair) for pair in data["pair_order"]]
    weights = data["pair_weight_numerators"]
    denominator = data["pair_weight_denominator"]
    assert len(order) == len(weights) == expected_s * q // 2
    assert len(set(order)) == len(order)
    assert all(0 <= i < j < expected_s for i, j in order)
    assert all(weight >= 0 for weight in weights)
    table = dict(zip(order, weights))
    capacities = []
    for span in range(1, q + 1):
        capacity = sum(table[(i, i + span)] for i in range(expected_s - span))
        capacities.append(capacity)
        assert capacity == 2 * denominator
    assert data["span_capacity_numerators"] == capacities


def main() -> None:
    seven_path = UPSTREAM / "candidate-retuned-p2736.json"
    nine_path = UPSTREAM / "candidate-nine-point-final.json"
    seven = load(seven_path.name)
    nine = load(nine_path.name)

    assert git_blob_sha(seven_path) == "a36fa0b2aa17a797456f118bd5d444120646c5aa"
    assert git_blob_sha(nine_path) == "ffbb37ae8f9fc3f8fc8948615e233c95f3e75904"
    assert git_blob_sha(UPSTREAM / "retuned-p2736-grid4000.txt") == (
        "2a2e1172b36ab6bad540d5e65e300fae7bd983fa"
    )
    assert git_blob_sha(UPSTREAM / "nine-point-final-grid4000.txt") == (
        "9916e9dae310664ef4252bf07d7a5a37a517277c"
    )

    assert seven["window_coefficient_denominator"] == nine["window_coefficient_denominator"]
    assert seven["window_coefficient_numerators"] == nine["window_coefficient_numerators"]
    assert fraction(seven["certified_window_baseline"]) == F(
        3_362_285_207, 5_000_000_000
    )
    assert fraction(nine["certified_window_baseline"]) == F(
        3_362_285_207, 5_000_000_000
    )

    audit_candidate(seven, 7, F(1, 2736), F(891, 200_000))
    audit_candidate(nine, 9, F(1, 2500), F(15_211, 2_500_000))

    seven_log = (UPSTREAM / "retuned-p2736-grid4000.txt").read_text()
    nine_log = (UPSTREAM / "nine-point-final-grid4000.txt").read_text()
    assert "verified=True" in seven_log and "nodes=2168370" in seven_log
    assert nine_log.count("verified=True") == 2
    assert "shards=[0,64) of 96" in nine_log and "shards=[64,96) of 96" in nine_log
    assert "nodes=78458316" in nine_log and "nodes=37814110" in nine_log
    assert 78_458_316 + 37_814_110 == 116_272_426

    print("upstream input audit PASSED")
    print("same window; nonnegative exact weights; all span capacities exactly 2")
    print("reported certificate logs and Git blob identities match the pinned commit")
    print("not replayed: upstream interval subdivision")


if __name__ == "__main__":
    main()
