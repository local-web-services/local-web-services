"""Architecture test: all Python files in test directories must follow naming conventions."""

from __future__ import annotations

import re

from lws_arch_tests._root import project_root

ALLOWED_PATTERN = re.compile(r"^(__init__|conftest|test_.+|_helpers)\.py$")


class TestFileNaming:
    def test_all_test_files_follow_naming_conventions(self):
        # Arrange
        root = project_root()
        tests_root = root / "tests"
        test_dirs = [
            tests_root / "unit",
            tests_root / "integration",
            tests_root / "e2e",
        ]
        violations = []

        # Act
        for test_dir in test_dirs:
            if not test_dir.exists():
                continue
            for path in sorted(test_dir.rglob("*.py")):
                if not ALLOWED_PATTERN.match(path.name):
                    rel = path.relative_to(tests_root)
                    violations.append(str(rel))

        # Assert
        assert (
            violations == []
        ), "Test files must be __init__.py, conftest.py, or test_*.py:\n" + "\n".join(
            f"  - {v}" for v in violations
        )
