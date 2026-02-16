"""Architecture test: E2E test files must not import httpx.

E2E tests exercise the full stack through the ``lws`` CLI (via ``CliRunner``,
``lws_invoke``, ``assert_invoke``).  Direct ``httpx`` usage bypasses the CLI
layer and should be replaced with CLI commands.
"""

from __future__ import annotations

import ast
from pathlib import Path

E2E_DIR = Path(__file__).parent.parent.parent.parent / "e2e"


def _find_httpx_imports(filepath: Path) -> list[int]:
    """Return line numbers of httpx imports in a Python file."""
    tree = ast.parse(filepath.read_text())
    lines = []
    for node in ast.walk(tree):
        if isinstance(node, ast.Import):
            for alias in node.names:
                if alias.name == "httpx" or alias.name.startswith("httpx."):
                    lines.append(node.lineno)
        elif isinstance(node, ast.ImportFrom) and node.module:
            if node.module == "httpx" or node.module.startswith("httpx."):
                lines.append(node.lineno)
    return lines


class TestNoHttpxImports:
    def test_e2e_files_do_not_import_httpx(self):
        # Arrange
        violations = []
        for path in sorted(E2E_DIR.rglob("*.py")):
            lines = _find_httpx_imports(path)
            if lines:
                rel = path.relative_to(E2E_DIR)
                violations.append(f"{rel} (lines {lines})")

        # Assert
        assert violations == [], (
            "E2E files must not import httpx. "
            "Use the lws CLI (via CliRunner) instead.\n" + "\n".join(f"  - {v}" for v in violations)
        )
