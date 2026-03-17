"""Architecture test: each unit test file must contain at most one class."""

from __future__ import annotations

import ast

from lws_arch_tests._root import project_root


def _count_classes(filepath) -> list[str]:
    tree = ast.parse(filepath.read_text())
    return [node.name for node in ast.iter_child_nodes(tree) if isinstance(node, ast.ClassDef)]


class TestOneClassPerFile:
    def test_unit_test_files_have_at_most_one_class(self):
        # Arrange
        unit_dir = project_root() / "tests" / "unit"
        violations = []

        # Act
        for path in sorted(unit_dir.rglob("test_*.py")):
            classes = _count_classes(path)
            if len(classes) > 1:
                rel = path.relative_to(unit_dir)
                violations.append(f"{rel} has {len(classes)} classes: {classes}")

        # Assert
        assert violations == [], "Unit test files must contain at most one class:\n" + "\n".join(
            f"  - {v}" for v in violations
        )
