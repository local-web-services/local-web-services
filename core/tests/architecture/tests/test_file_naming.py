"""Architecture test: all Python files in test directories must follow naming conventions."""

from __future__ import annotations

import re
from pathlib import Path

TESTS_ROOT = Path(__file__).parent.parent.parent
TEST_DIRS = [
    TESTS_ROOT / "unit",
    TESTS_ROOT / "integration",
    TESTS_ROOT / "e2e",
]

ALLOWED_PATTERN = re.compile(r"^(__init__|conftest|test_.+|_helpers)\.py$")


class TestFileNaming:
    def test_all_test_files_follow_naming_conventions(self):
        violations = []
        for test_dir in TEST_DIRS:
            if not test_dir.exists():
                continue
            for path in sorted(test_dir.rglob("*.py")):
                if not ALLOWED_PATTERN.match(path.name):
                    rel = path.relative_to(TESTS_ROOT)
                    violations.append(str(rel))

        assert (
            violations == []
        ), "Test files must be __init__.py, conftest.py, or test_*.py:\n" + "\n".join(
            f"  - {v}" for v in violations
        )
