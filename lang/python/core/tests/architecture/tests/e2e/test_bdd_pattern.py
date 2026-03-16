"""Architecture test: E2E tests must use Gherkin / pytest-bdd pattern.

Each service directory must have a ``test_scenarios.py`` that loads all feature files
from the global informal spec via ``scenarios(...)``, OR be a recognised placeholder
(its content contains the string "Placeholder").  No ``Test*`` classes are allowed.
"""

from __future__ import annotations

import ast
from pathlib import Path

E2E_DIR = Path(__file__).parent.parent.parent.parent / "e2e"


class TestBddPattern:
    def test_e2e_test_files_use_scenarios(self):
        """Every test_*.py must call scenarios() from pytest_bdd (or be a Placeholder stub)."""
        # Arrange
        violations = []

        # Act
        for path in sorted(E2E_DIR.rglob("test_*.py")):
            source = path.read_text()
            if "Placeholder" in source:
                continue
            if "scenarios(" not in source:
                rel = path.relative_to(E2E_DIR)
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
        violations = []

        # Act
        for path in sorted(E2E_DIR.rglob("test_*.py")):
            tree = ast.parse(path.read_text())
            classes = [
                node.name
                for node in ast.iter_child_nodes(tree)
                if isinstance(node, ast.ClassDef) and node.name.startswith("Test")
            ]
            if classes:
                rel = path.relative_to(E2E_DIR)
                violations.append(f"{rel} has classes: {classes}")

        # Assert
        assert (
            violations == []
        ), "E2E test files must not contain Test* classes (use BDD instead):\n" + "\n".join(
            f"  - {v}" for v in violations
        )
