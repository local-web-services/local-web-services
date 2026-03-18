"""Architecture test: E2E tests must use Gherkin / pytest-bdd pattern."""

from __future__ import annotations

import ast

from lws_arch_tests._root import project_root


class TestBddPattern:
    def test_e2e_test_files_use_scenarios(self):
        """Every test_*.py must call scenarios() from pytest_bdd (or be a Placeholder stub)."""
        # Arrange
        e2e_dir = project_root() / "tests" / "e2e"
        violations = []

        # Act
        for path in sorted(e2e_dir.rglob("test_*.py")):
            source = path.read_text()
            if "Placeholder" in source:
                continue
            if "scenarios(" not in source:
                rel = path.relative_to(e2e_dir)
                violations.append(f"{rel} does not call scenarios()")

        # Assert
        assert (
            violations == []
        ), "E2E test files must use pytest-bdd scenarios() wiring:\n" + "\n".join(
            f"  - {v}" for v in violations
        )

    def test_e2e_test_files_have_no_test_classes(self):
        """No test_*.py file should contain a Test* class."""
        # Arrange
        e2e_dir = project_root() / "tests" / "e2e"
        violations = []

        # Act
        for path in sorted(e2e_dir.rglob("test_*.py")):
            tree = ast.parse(path.read_text())
            classes = [
                node.name
                for node in ast.iter_child_nodes(tree)
                if isinstance(node, ast.ClassDef) and node.name.startswith("Test")
            ]
            if classes:
                rel = path.relative_to(e2e_dir)
                violations.append(f"{rel} has classes: {classes}")

        # Assert
        assert (
            violations == []
        ), "E2E test files must not contain Test* classes (use BDD instead):\n" + "\n".join(
            f"  - {v}" for v in violations
        )
