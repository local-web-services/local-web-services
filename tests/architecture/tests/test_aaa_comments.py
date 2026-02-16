"""Architecture test: every test method must use AAA (Arrange-Act-Assert) comments.

Scans test methods (functions named ``test_*`` inside classes named ``Test*``)
in ``tests/unit/`` and ``tests/integration/`` and verifies that each contains at
minimum ``# Act`` and ``# Assert`` comments.  ``# Arrange`` is recommended but not
enforced because some tests legitimately have no setup phase.

E2E tests are excluded because they use Gherkin / pytest-bdd instead of AAA.

Because the codebase has existing violations, a ratchet threshold is used so the test
passes today but prevents new violations from being added.
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
                # Skip architecture tests
                try:
                    path.relative_to(ARCHITECTURE_DIR)
                    continue
                except ValueError:
                    pass
                files.append(path)
    return files


def _extract_test_methods(tree: ast.Module) -> list[tuple[str, str, ast.FunctionDef]]:
    """Return (class_name, method_name, node) for every test method in a Test* class."""
    results: list[tuple[str, str, ast.FunctionDef]] = []
    for node in ast.walk(tree):
        if isinstance(node, ast.ClassDef) and node.name.startswith("Test"):
            for item in ast.walk(node):
                if isinstance(item, (ast.FunctionDef, ast.AsyncFunctionDef)):
                    if item.name.startswith("test_"):
                        results.append((node.name, item.name, item))
    return results


def _get_function_source_lines(filepath: Path, func_node: ast.FunctionDef) -> list[str]:
    """Return the source lines of a function body."""
    all_lines = filepath.read_text().splitlines()
    # func_node.lineno is 1-indexed; end_lineno is inclusive
    start = func_node.lineno - 1
    end = func_node.end_lineno if func_node.end_lineno else start + 1
    return all_lines[start:end]


def _check_aaa_comments(lines: list[str]) -> list[str]:
    """Return a list of missing required AAA comments (Act and Assert only)."""
    text = "\n".join(lines)
    missing: list[str] = []
    if "# Act" not in text:
        missing.append("Act")
    if "# Assert" not in text:
        missing.append("Assert")
    return missing


class TestAaaComments:
    def test_all_test_methods_have_aaa_comments(self):
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

            for class_name, method_name, func_node in _extract_test_methods(tree):
                lines = _get_function_source_lines(filepath, func_node)
                missing = _check_aaa_comments(lines)
                if missing:
                    rel = filepath.relative_to(REPO_ROOT)
                    violations.append(
                        f"{rel}:{class_name}.{method_name} missing [{', '.join(missing)}]"
                    )

        # Ratchet: reduce this number as AAA comments are added to existing tests
        CURRENT_COUNT = 825

        # Assert
        assert len(violations) <= CURRENT_COUNT, (
            f"Found {len(violations)} test method(s) missing required AAA comments "
            f"(# Act and/or # Assert), threshold is {CURRENT_COUNT}. "
            f"New test methods must include # Act and # Assert comments.\n"
            + "\n".join(f"  - {v}" for v in violations)
        )
