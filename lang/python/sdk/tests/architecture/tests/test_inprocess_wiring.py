"""Architecture test: inprocess.py service wiring consistency.

Every service registered in _create_providers must appear in _SERVICE_NAMES
so it gets a socket and port allocation at startup.

Missing this causes 'Service X is not available in this session' at E2E test
time rather than a clear error at startup.
"""

from __future__ import annotations

import ast
import os
from pathlib import Path


def _inprocess_path() -> Path:
    return (
        Path(os.environ["LWS_ARCH_PROJECT_ROOT"])
        / "src"
        / "lws_testing"
        / "_transport"
        / "inprocess.py"
    )


def _extract_service_names(tree: ast.AST) -> set[str]:
    """Extract string items from the module-level _SERVICE_NAMES list."""
    for node in ast.walk(tree):
        if not isinstance(node, ast.Assign):
            continue
        for target in node.targets:
            if isinstance(target, ast.Name) and target.id == "_SERVICE_NAMES":
                if isinstance(node.value, ast.List):
                    return {
                        elt.value
                        for elt in node.value.elts
                        if isinstance(elt, ast.Constant) and isinstance(elt.value, str)
                    }
    return set()


def _extract_provider_keys(tree: ast.AST) -> set[str]:
    """Extract string keys from the dict returned by _create_providers."""
    for node in ast.walk(tree):
        if not isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
            continue
        if node.name != "_create_providers":
            continue
        for child in ast.walk(node):
            if isinstance(child, ast.Return) and isinstance(child.value, ast.Dict):
                return {
                    k.value
                    for k in child.value.keys
                    if isinstance(k, ast.Constant) and isinstance(k.value, str)
                }
    return set()


class TestInprocessWiring:
    def test_all_providers_are_in_service_names(self):
        """Every service in _create_providers must appear in _SERVICE_NAMES.

        _SERVICE_NAMES drives socket allocation. A provider without a matching
        entry gets no socket and no port, causing LwsSession.client() to raise
        'Service X is not available in this session' at E2E test time.
        """
        # Arrange
        source = _inprocess_path().read_text()
        tree = ast.parse(source)
        expected_service_names = _extract_provider_keys(tree)

        # Act
        actual_service_names = _extract_service_names(tree)

        # Assert
        missing = expected_service_names - actual_service_names
        assert missing == set(), (
            "These services are created in _create_providers but missing from _SERVICE_NAMES "
            "(add them so sockets and ports are allocated at startup):\n"
            + "\n".join(f"  - {s}" for s in sorted(missing))
        )
