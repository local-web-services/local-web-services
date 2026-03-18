"""Architecture test: source code must not use bare ``except:`` clauses."""

from __future__ import annotations

import ast
from pathlib import Path

from lws_arch_tests._root import project_root


class TestNoBareExcept:
    def test_no_bare_except_in_source(self):
        # Arrange
        src_dir = project_root() / "src"
        violations = []

        # Act
        for py_file in sorted(src_dir.rglob("*.py")):
            try:
                tree = ast.parse(py_file.read_text())
            except SyntaxError:
                continue
            for node in ast.walk(tree):
                if isinstance(node, ast.ExceptHandler) and node.type is None:
                    violations.append(f"{py_file}:{node.lineno} - bare except clause")

        # Assert
        assert violations == [], "Bare except clauses found:\n" + "\n".join(
            f"  - {v}" for v in violations
        )
