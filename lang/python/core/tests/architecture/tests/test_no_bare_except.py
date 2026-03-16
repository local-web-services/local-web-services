"""Architecture test: source code must not use bare ``except:`` clauses."""

from __future__ import annotations

import ast
from pathlib import Path

SRC_DIR = Path(__file__).parent.parent.parent.parent / "src" / "lws"


class TestNoBareExcept:
    def test_no_bare_except_in_source(self):
        """All except clauses must specify an exception type."""
        violations = []
        for py_file in sorted(SRC_DIR.rglob("*.py")):
            try:
                tree = ast.parse(py_file.read_text())
            except SyntaxError:
                continue
            for node in ast.walk(tree):
                if isinstance(node, ast.ExceptHandler) and node.type is None:
                    violations.append(f"{py_file}:{node.lineno} - bare except clause")

        assert violations == [], "Bare except clauses found:\n" + "\n".join(
            f"  - {v}" for v in violations
        )
