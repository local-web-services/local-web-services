"""Architecture test: integration test methods that accept a client parameter must be async."""

from __future__ import annotations

import ast
from pathlib import Path

INTEGRATION_DIR = Path(__file__).parent.parent.parent.parent / "integration"


def _check_async_consistency(filepath: Path) -> list[str]:
    """Return violation descriptions for sync test methods that accept a client parameter."""
    tree = ast.parse(filepath.read_text())
    violations = []
    for node in ast.walk(tree):
        if not isinstance(node, ast.ClassDef):
            continue
        if not node.name.startswith("Test"):
            continue
        for item in node.body:
            if not isinstance(item, (ast.FunctionDef, ast.AsyncFunctionDef)):
                continue
            if not item.name.startswith("test_"):
                continue
            param_names = [arg.arg for arg in item.args.args]
            if "client" not in param_names:
                continue
            if isinstance(item, ast.AsyncFunctionDef):
                continue
            rel = filepath.relative_to(INTEGRATION_DIR)
            violations.append(
                f"{rel}::{node.name}::{item.name} has 'client' param but is not async"
            )
    return violations


class TestAsyncConsistency:
    def test_integration_test_methods_with_client_are_async(self):
        violations = []
        for path in sorted(INTEGRATION_DIR.rglob("test_*.py")):
            violations.extend(_check_async_consistency(path))

        assert (
            violations == []
        ), "Integration test methods with 'client' parameter must be async def:\n" + "\n".join(
            f"  - {v}" for v in violations
        )
