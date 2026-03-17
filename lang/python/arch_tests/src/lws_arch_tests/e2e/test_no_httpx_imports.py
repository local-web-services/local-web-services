"""Architecture test: E2E test files must not import httpx."""

from __future__ import annotations

import ast

from lws_arch_tests._root import project_root


def _find_httpx_imports(filepath) -> list[int]:
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
        e2e_dir = project_root() / "tests" / "e2e"
        violations = []

        # Act
        for path in sorted(e2e_dir.rglob("*.py")):
            lines = _find_httpx_imports(path)
            if lines:
                rel = path.relative_to(e2e_dir)
                violations.append(f"{rel} (lines {lines})")

        # Assert
        assert violations == [], (
            "E2E files must not import httpx. "
            "Use the lws CLI (via CliRunner) instead.\n"
            + "\n".join(f"  - {v}" for v in violations)
        )
