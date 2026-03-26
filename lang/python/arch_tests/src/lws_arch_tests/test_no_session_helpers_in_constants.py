"""Architecture test: constants.py in step directories must not contain session helpers."""
from __future__ import annotations

import ast

from lws_arch_tests._root import project_root
from lws_arch_tests._step_dirs import SESSION_PARAM_NAMES, find_step_service_dirs


class TestNoSessionHelpersInConstants:
    def test_constants_has_no_session_helpers(self):
        # Arrange
        root = project_root()
        violations: list[str] = []

        # Act
        for service_dir in find_step_service_dirs(root):
            constants_py = service_dir / "constants.py"
            if not constants_py.exists():
                continue
            tree = ast.parse(constants_py.read_text(encoding="utf-8"))
            for node in tree.body:
                if not isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
                    continue
                if node.args.args and node.args.args[0].arg in SESSION_PARAM_NAMES:
                    rel = constants_py.relative_to(root)
                    violations.append(
                        f"{rel}: {node.name}() has session param '{node.args.args[0].arg}'"
                        " — move to client.py"
                    )

        # Assert
        assert violations == [], (
            "Session helper functions must live in client.py, not constants.py:\n"
            + "\n".join(f"  - {v}" for v in violations)
        )
