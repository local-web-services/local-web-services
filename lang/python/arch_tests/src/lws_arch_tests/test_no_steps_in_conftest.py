"""Architecture test: conftest.py in step directories must not define step functions."""
from __future__ import annotations

import ast

from lws_arch_tests._root import project_root
from lws_arch_tests._step_dirs import STEP_DECORATOR_NAMES, find_step_service_dirs


class TestNoStepsInConftest:
    def test_no_steps_in_conftest(self):
        # Arrange
        root = project_root()
        violations: list[str] = []

        # Act
        for service_dir in find_step_service_dirs(root):
            conftest_py = service_dir / "conftest.py"
            if not conftest_py.exists():
                continue
            tree = ast.parse(conftest_py.read_text(encoding="utf-8"))
            for node in ast.walk(tree):
                if not isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
                    continue
                for dec in node.decorator_list:
                    if isinstance(dec, ast.Call) and isinstance(dec.func, ast.Name):
                        if dec.func.id in STEP_DECORATOR_NAMES:
                            rel = conftest_py.relative_to(root)
                            violations.append(
                                f"{rel}: @{dec.func.id} '{node.name}'"
                                f" — move to {dec.func.id}/ directory"
                            )

        # Assert
        assert violations == [], (
            "conftest.py must not define step functions — move them to given/when/then/:\n"
            + "\n".join(f"  - {v}" for v in violations)
        )
