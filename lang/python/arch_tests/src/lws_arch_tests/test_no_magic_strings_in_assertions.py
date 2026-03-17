"""Architecture test: no magic strings in assertion comparisons.

Scans test methods in ``tests/unit/`` and ``tests/integration/`` and flags
``assert x == "literal"`` or ``assert "literal" == x`` patterns where a string
constant is used directly as a comparator.  This encourages extracting expected
values into named variables (e.g. ``expected_name = "literal"``).

E2E tests are excluded because they use Gherkin / pytest-bdd.

Because the codebase has existing violations, a ratchet threshold is used so the test
passes today but prevents new magic strings from being added.  Each project's wrapper
subclass sets the appropriate RATCHET value.
"""

from __future__ import annotations

import ast
from pathlib import Path

from lws_arch_tests._root import project_root

SKIP_FILENAMES = {"conftest.py", "__init__.py"}


def _test_dirs(root: Path) -> list[Path]:
    return [root / "tests" / "unit", root / "tests" / "integration"]


def _collect_test_files(root: Path) -> list[Path]:
    architecture_dir = root / "tests" / "architecture"
    files: list[Path] = []
    for test_dir in _test_dirs(root):
        if not test_dir.exists():
            continue
        for path in sorted(test_dir.rglob("test_*.py")):
            if path.name in SKIP_FILENAMES:
                continue
            try:
                path.relative_to(architecture_dir)
                continue
            except ValueError:
                pass
            files.append(path)
    return files


def _is_magic_string(node: ast.expr) -> bool:
    return isinstance(node, ast.Constant) and isinstance(node.value, str) and node.value != ""


def _find_magic_string_comparisons(
    func_node: ast.FunctionDef | ast.AsyncFunctionDef,
) -> list[tuple[int, str]]:
    violations: list[tuple[int, str]] = []
    for node in ast.walk(func_node):
        if not isinstance(node, ast.Assert):
            continue
        test_expr = node.test
        if not isinstance(test_expr, ast.Compare):
            continue
        if len(test_expr.ops) != 1 or len(test_expr.comparators) != 1:
            continue
        op = test_expr.ops[0]
        if not isinstance(op, ast.Eq):
            continue
        left = test_expr.left
        right = test_expr.comparators[0]
        magic_value = None
        if _is_magic_string(right):
            magic_value = right.value  # type: ignore[union-attr]
        elif _is_magic_string(left):
            magic_value = left.value  # type: ignore[union-attr]
        if magic_value is not None:
            display = magic_value if len(magic_value) <= 60 else magic_value[:57] + "..."
            violations.append((node.lineno, display))
    return violations


def _extract_test_methods(
    tree: ast.Module,
) -> list[ast.FunctionDef | ast.AsyncFunctionDef]:
    results: list[ast.FunctionDef | ast.AsyncFunctionDef] = []
    for node in ast.walk(tree):
        if isinstance(node, ast.ClassDef) and node.name.startswith("Test"):
            for item in ast.walk(node):
                if isinstance(item, (ast.FunctionDef, ast.AsyncFunctionDef)):
                    if item.name.startswith("test_"):
                        results.append(item)
    return results


class TestNoMagicStringsInAssertions:
    RATCHET = 0

    def test_no_new_magic_strings_in_assertions(self):
        # Arrange
        root = project_root()
        violations: list[str] = []
        test_files = _collect_test_files(root)

        # Act
        for filepath in test_files:
            try:
                source = filepath.read_text()
                tree = ast.parse(source)
            except SyntaxError:
                continue

            rel = filepath.relative_to(root)
            for func_node in _extract_test_methods(tree):
                for lineno, magic_str in _find_magic_string_comparisons(func_node):
                    violations.append(
                        f'{rel}:{lineno} - assert compares against magic string "{magic_str}"'
                    )

        # Assert
        assert len(violations) <= self.RATCHET, (
            f"Found {len(violations)} magic string comparison(s) in assertions "
            f"(threshold is {self.RATCHET}). "
            f"New assertions must not compare against magic strings; "
            f"extract expected values into named variables.\n"
            + "\n".join(f"  - {v}" for v in violations)
        )
