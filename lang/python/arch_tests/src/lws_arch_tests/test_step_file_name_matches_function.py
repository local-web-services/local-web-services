"""Architecture test: step file stem must match the decorated function name."""
from __future__ import annotations

import ast

from lws_arch_tests._root import project_root
from lws_arch_tests._step_dirs import (
    STEP_DECORATOR_NAMES,
    find_step_service_dirs,
    iter_step_files,
)


def _step_function_name(tree: ast.Module) -> str | None:
    """Return the name of the first step-decorated function, or None."""
    for node in ast.walk(tree):
        if not isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
            continue
        for dec in node.decorator_list:
            if isinstance(dec, ast.Call) and isinstance(dec.func, ast.Name):
                if dec.func.id in STEP_DECORATOR_NAMES:
                    return node.name
    return None


class TestStepFileNameMatchesFunction:
    def test_step_file_name_matches_function(self):
        # Arrange
        root = project_root()
        violations: list[str] = []

        # Act
        for service_dir in find_step_service_dirs(root):
            for step_file in iter_step_files(service_dir):
                tree = ast.parse(step_file.read_text(encoding="utf-8"))
                func_name = _step_function_name(tree)
                if func_name is None:
                    continue  # no step found — caught by test_one_step_per_file
                dir_name = step_file.parent.name  # "given", "when", or "then"
                # Allow exact match OR stem + _{dir_name} suffix for disambiguation
                allowed = {step_file.stem, f"{step_file.stem}_{dir_name}"}
                if func_name not in allowed:
                    rel = step_file.relative_to(root)
                    violations.append(
                        f"{rel}: file is '{step_file.stem}.py'"
                        f" but function is '{func_name}'"
                    )

        # Assert
        assert violations == [], (
            "Step file names must match the function they define:\n"
            + "\n".join(f"  - {v}" for v in violations)
        )
