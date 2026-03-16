"""Architecture test: E2E tests must never be skipped.

All E2E tests must run in every environment (local and CI).  If a test
requires an external dependency such as Docker, CI must be configured to
provide it.  Feature files must not carry ``@skip``, ``@wip``, or
``@xfail`` tags, and conftest hooks must not add ``pytest.mark.skip``
markers.
"""

from __future__ import annotations

import ast
from pathlib import Path

E2E_DIR = Path(__file__).parent.parent.parent.parent / "e2e"


class TestNoSkippedE2eTests:
    def test_feature_files_have_no_skip_tags(self):
        """No feature file may use @skip, @wip, or @xfail tags."""
        # Arrange
        skip_tags = {"@skip", "@wip", "@xfail"}
        violations = []

        # Act
        for path in sorted(E2E_DIR.rglob("*.feature")):
            for line_no, line in enumerate(path.read_text().splitlines(), start=1):
                stripped = line.strip()
                if not stripped.startswith("@"):
                    continue
                tags = {t.lower() for t in stripped.split() if t.startswith("@")}
                found = tags & skip_tags
                if found:
                    rel = path.relative_to(E2E_DIR)
                    violations.append(f"{rel}:{line_no} has forbidden tags: {found}")

        # Assert
        assert (
            violations == []
        ), "E2E feature files must not use skip/wip/xfail tags:\n" + "\n".join(
            f"  - {v}" for v in violations
        )

    def test_conftest_does_not_unconditionally_skip(self):
        """No conftest.py may use pytest.mark.skip without a clear reason check."""
        # Arrange
        violations = []

        # Act
        for path in sorted(E2E_DIR.rglob("conftest.py")):
            source = path.read_text()
            tree = ast.parse(source)
            for node in ast.walk(tree):
                if not isinstance(node, ast.Attribute):
                    continue
                # Detect pytest.mark.skipif or pytest.skip used as decorators
                if node.attr in ("skipif",) and _is_pytest_mark(node):
                    rel = path.relative_to(E2E_DIR)
                    violations.append(
                        f"{rel}:{node.lineno} uses pytest.mark.skipif "
                        "(use CI configuration to provide dependencies instead)"
                    )

        # Assert
        assert violations == [], "E2E conftest files must not use skipif markers:\n" + "\n".join(
            f"  - {v}" for v in violations
        )

    def test_no_skip_decorators_on_test_functions(self):
        """No test file may have @pytest.mark.skip decorators."""
        # Arrange
        violations = []

        # Act
        for path in sorted(E2E_DIR.rglob("test_*.py")):
            source = path.read_text()
            tree = ast.parse(source)
            for node in ast.walk(tree):
                if not isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
                    continue
                for decorator in node.decorator_list:
                    if _decorator_is_skip(decorator):
                        rel = path.relative_to(E2E_DIR)
                        violations.append(f"{rel}:{node.lineno} {node.name} has skip decorator")

        # Assert
        assert (
            violations == []
        ), "E2E test functions must not be decorated with skip:\n" + "\n".join(
            f"  - {v}" for v in violations
        )


def _is_pytest_mark(node: ast.Attribute) -> bool:
    """Check if an Attribute node is pytest.mark.*."""
    if isinstance(node.value, ast.Attribute) and node.value.attr == "mark":
        if isinstance(node.value.value, ast.Name) and node.value.value.id == "pytest":
            return True
    return False


def _decorator_is_skip(node: ast.expr) -> bool:
    """Check if a decorator AST node represents pytest.mark.skip or skipif."""
    if isinstance(node, ast.Attribute) and node.attr in ("skip", "skipif"):
        return _is_pytest_mark(node)
    if isinstance(node, ast.Call) and isinstance(node.func, ast.Attribute):
        return node.func.attr in ("skip", "skipif") and _is_pytest_mark(node.func)
    return False
