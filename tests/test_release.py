"""Small standard-library tests for the local deduction package."""

from __future__ import annotations

import contextlib
import io
import sys
import unittest
from decimal import Decimal, localcontext
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

import check_upstream_inputs  # noqa: E402
import exact_check  # noqa: E402
import joint_check  # noqa: E402


class ReleaseTests(unittest.TestCase):
    def test_exact_comparison(self) -> None:
        with contextlib.redirect_stdout(io.StringIO()):
            exact_check.main()

    def test_upstream_snapshot_compatibility(self) -> None:
        with contextlib.redirect_stdout(io.StringIO()):
            check_upstream_inputs.main()

    def test_winning_block_length_locally(self) -> None:
        with localcontext() as decimal_context:
            decimal_context.prec = 100
            values = {
                m: joint_check.candidate(m)[0]
                for m in range(215, 224)
                if joint_check.candidate(m) is not None
            }
        self.assertEqual(max(values, key=values.get), 219)
        self.assertGreater(values[219], Decimal("0.673316977"))


if __name__ == "__main__":
    unittest.main()
