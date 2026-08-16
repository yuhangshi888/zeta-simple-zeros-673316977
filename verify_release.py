"""Dependency-free release check for the local deduction package.

This verifies file integrity and runs the two light exact/formula checks.
It intentionally does not replay the imported upstream interval certificates.
"""

from __future__ import annotations

import hashlib
import subprocess
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parent


def release_files() -> set[str]:
    """Return the files that must be represented in the release manifest."""
    generated_suffixes = (".aux", ".log", ".out", ".synctex.gz", ".xdv")
    ignored_directories = {".git", ".lake", "__pycache__", "tmp"}
    files: set[str] = set()
    for path in ROOT.rglob("*"):
        if not path.is_file():
            continue
        relative = path.relative_to(ROOT)
        name = relative.as_posix()
        if name == "MANIFEST.sha256":
            continue
        if any(part in ignored_directories for part in relative.parts):
            continue
        if name.endswith(generated_suffixes):
            continue
        files.add(name)
    return files


def verify_manifest() -> None:
    lines = (ROOT / "MANIFEST.sha256").read_text(encoding="utf-8").splitlines()
    listed: set[str] = set()
    for line_number, line in enumerate(lines, 1):
        if not line.strip():
            continue
        try:
            digest, relative = line.split(maxsplit=1)
        except ValueError as error:
            raise SystemExit(f"malformed manifest line {line_number}") from error
        relative = relative.removeprefix("./")
        if relative in listed:
            raise SystemExit(f"duplicate manifest entry on line {line_number}: {relative}")
        listed.add(relative)
        path = ROOT / relative
        if not path.is_file():
            raise SystemExit(f"manifest file is missing: {relative}")
        actual = hashlib.sha256(path.read_bytes()).hexdigest()
        if actual != digest:
            raise SystemExit(
                f"manifest mismatch on line {line_number}: {relative}"
            )
        print(f"manifest OK: {relative}")

    actual_files = release_files()
    missing_entries = sorted(actual_files - listed)
    nonexistent_entries = sorted(listed - actual_files)
    if missing_entries:
        raise SystemExit("files absent from manifest: " + ", ".join(missing_entries))
    if nonexistent_entries:
        raise SystemExit(
            "manifest entries absent from release: " + ", ".join(nonexistent_entries)
        )
    print(f"manifest completeness OK: {len(listed)} files")


def run_check(script: str) -> None:
    print(f"running {script}")
    subprocess.run([sys.executable, str(ROOT / script)], check=True, cwd=ROOT)


def main() -> None:
    verify_manifest()
    run_check("check_upstream_inputs.py")
    run_check("exact_check.py")
    run_check("joint_check.py")
    print("release check PASSED")
    print("scope: local deduction and exact arithmetic only")
    print("not replayed: imported upstream interval certificates")


if __name__ == "__main__":
    main()
