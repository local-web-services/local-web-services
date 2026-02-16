"""Architecture test: no magic strings in assertion comparisons.

Scans test methods in ``tests/unit/`` and ``tests/integration/`` and flags
``assert x == "literal"`` or ``assert "literal" == x`` patterns where a string
constant is used directly as a comparator.  This encourages extracting expected
values into named variables (e.g. ``expected_name = "literal"``).

E2E tests are excluded because they use Gherkin / pytest-bdd.

Because the codebase has existing violations, a ratchet threshold is used so the test
passes today but prevents new magic strings from being added.
"""

from __future__ import annotations

import ast
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent.parent.parent
TEST_DIRS = [
    REPO_ROOT / "tests" / "unit",
    REPO_ROOT / "tests" / "integration",
]
ARCHITECTURE_DIR = REPO_ROOT / "tests" / "architecture"
SKIP_FILENAMES = {"conftest.py", "__init__.py"}


def _collect_test_files() -> list[Path]:
    """Collect all test_*.py files from the scanned directories."""
    files: list[Path] = []
    for test_dir in TEST_DIRS:
        if test_dir.exists():
            for path in sorted(test_dir.rglob("test_*.py")):
                if path.name in SKIP_FILENAMES:
                    continue
                try:
                    path.relative_to(ARCHITECTURE_DIR)
                    continue
                except ValueError:
                    pass
                files.append(path)
    return files


def _is_magic_string(node: ast.expr) -> bool:
    """Return True if node is a string constant that is not empty."""
    return isinstance(node, ast.Constant) and isinstance(node.value, str) and node.value != ""


def _find_magic_string_comparisons(
    func_node: ast.FunctionDef | ast.AsyncFunctionDef,
) -> list[tuple[int, str]]:
    """Find assert statements with magic string comparisons (== or !=).

    Only flags ``assert x == "literal"`` or ``assert "literal" == x`` patterns
    where one side of an ``ast.Eq`` comparison is a string constant.
    """
    violations: list[tuple[int, str]] = []

    for node in ast.walk(func_node):
        if not isinstance(node, ast.Assert):
            continue

        test_expr = node.test

        # Handle assert <compare>
        if not isinstance(test_expr, ast.Compare):
            continue

        # We only look at simple comparisons: exactly one operator
        if len(test_expr.ops) != 1 or len(test_expr.comparators) != 1:
            continue

        op = test_expr.ops[0]
        if not isinstance(op, ast.Eq):
            continue

        left = test_expr.left
        right = test_expr.comparators[0]

        # Flag if left or right is a magic string constant
        magic_value = None
        if _is_magic_string(right):
            magic_value = right.value
        elif _is_magic_string(left):
            magic_value = left.value

        if magic_value is not None:
            # Truncate long strings for readability
            display = magic_value if len(magic_value) <= 60 else magic_value[:57] + "..."
            violations.append((node.lineno, display))

    return violations


def _extract_test_methods(
    tree: ast.Module,
) -> list[ast.FunctionDef | ast.AsyncFunctionDef]:
    """Return all test methods (test_* inside Test* classes)."""
    results: list[ast.FunctionDef | ast.AsyncFunctionDef] = []
    for node in ast.walk(tree):
        if isinstance(node, ast.ClassDef) and node.name.startswith("Test"):
            for item in ast.walk(node):
                if isinstance(item, (ast.FunctionDef, ast.AsyncFunctionDef)):
                    if item.name.startswith("test_"):
                        results.append(item)
    return results


class TestNoMagicStringsInAssertions:
    def test_no_new_magic_strings_in_assertions(self):
        # Arrange
        violations: list[str] = []
        test_files = _collect_test_files()

        # Act
        for filepath in test_files:
            try:
                source = filepath.read_text()
                tree = ast.parse(source)
            except SyntaxError:
                continue

            rel = filepath.relative_to(REPO_ROOT)
            for func_node in _extract_test_methods(tree):
                for lineno, magic_str in _find_magic_string_comparisons(func_node):
                    violations.append(
                        f'{rel}:{lineno} - assert compares against magic string "{magic_str}"'
                    )

        # Ratchet: reduce this number as magic strings are eliminated
        CURRENT_COUNT = 81

        # Assert
        assert len(violations) <= CURRENT_COUNT, (
            f"Found {len(violations)} magic string comparison(s) in assertions "
            f"(threshold is {CURRENT_COUNT}). "
            f"New assertions must not compare against magic strings; "
            f"extract expected values into named variables.\n"
            + "\n".join(f"  - {v}" for v in violations)
        )
