"""Architecture test: E2E files must not access .endpoint_url."""

from __future__ import annotations

import ast

from lws_arch_tests._root import project_root


def _find_endpoint_url_accesses(filepath) -> list[int]:
    tree = ast.parse(filepath.read_text())
    return [
        node.lineno
        for node in ast.walk(tree)
        if isinstance(node, ast.Attribute) and node.attr == "endpoint_url"
    ]


class TestNoEndpointUrlInE2e:
    def test_e2e_files_do_not_use_endpoint_url(self):
        """E2E files must not access .endpoint_url.

        LwsSession exposes management_url for the /_ldk/* management API.
        Using endpoint_url raises AttributeError at runtime.
        """
        # Arrange
        e2e_dir = project_root() / "tests" / "e2e"
        violations = []

        # Act
        for path in sorted(e2e_dir.rglob("*.py")):
            lines = _find_endpoint_url_accesses(path)
            if lines:
                rel = path.relative_to(e2e_dir)
                violations.append(f"{rel} (lines {lines})")

        # Assert
        assert violations == [], (
            "E2E files must not use .endpoint_url — use lws_session.management_url instead:\n"
            + "\n".join(f"  - {v}" for v in violations)
        )
