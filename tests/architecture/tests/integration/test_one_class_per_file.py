"""Architecture test: each integration test file must contain at most one test class."""

from __future__ import annotations

import ast
from pathlib import Path

INTEGRATION_DIR = Path(__file__).parent.parent.parent.parent / "integration"


def _count_classes(filepath: Path) -> list[str]:
    """Return the names of all top-level classes in a Python file."""
    tree = ast.parse(filepath.read_text())
    return [node.name for node in ast.iter_child_nodes(tree) if isinstance(node, ast.ClassDef)]


class TestOneClassPerFile:
    def test_integration_test_files_have_at_most_one_class(self):
        violations = []
        for path in sorted(INTEGRATION_DIR.glob("test_*.py")):
            classes = _count_classes(path)
            if len(classes) > 1:
                violations.append(f"{path.name} has {len(classes)} classes: {classes}")

        assert (
            violations == []
        ), "Integration test files must contain at most one test class:\n" + "\n".join(
            f"  - {v}" for v in violations
        )
