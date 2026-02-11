"""Architecture test: each e2e test file must contain at most one test class."""

from __future__ import annotations

import ast
from pathlib import Path

E2E_DIR = Path(__file__).parent.parent.parent.parent / "e2e"


def _count_classes(filepath: Path) -> list[str]:
    """Return the names of all top-level classes in a Python file."""
    tree = ast.parse(filepath.read_text())
    return [node.name for node in ast.iter_child_nodes(tree) if isinstance(node, ast.ClassDef)]


class TestOneClassPerFile:
    def test_e2e_test_files_have_at_most_one_class(self):
        violations = []
        for path in sorted(E2E_DIR.rglob("test_*.py")):
            classes = _count_classes(path)
            if len(classes) > 1:
                rel = path.relative_to(E2E_DIR)
                violations.append(f"{rel} has {len(classes)} classes: {classes}")

        assert violations == [], "E2E test files must contain at most one class:\n" + "\n".join(
            f"  - {v}" for v in violations
        )
