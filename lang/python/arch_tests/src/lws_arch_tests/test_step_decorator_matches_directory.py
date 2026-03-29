"""Architecture test: @given must be in given/, @when in when/, @then in then/."""
from __future__ import annotations

import ast

from lws_arch_tests._root import project_root
from lws_arch_tests._step_dirs import (
    STEP_DECORATOR_NAMES,
    find_step_service_dirs,
    iter_step_files,
)


def _decorator_names(node: ast.FunctionDef | ast.AsyncFunctionDef) -> list[str]:
    names = []
    for dec in node.decorator_list:
        if isinstance(dec, ast.Call) and isinstance(dec.func, ast.Name):
            if dec.func.id in STEP_DECORATOR_NAMES:
                names.append(dec.func.id)
    return names


class TestStepDecoratorMatchesDirectory:
    def test_step_decorator_matches_directory(self):
        # Arrange
        root = project_root()
        violations: list[str] = []

        # Act
        for service_dir in find_step_service_dirs(root):
            for step_file in iter_step_files(service_dir):
                expected_dir = step_file.parent.name  # "given", "when", or "then"
                tree = ast.parse(step_file.read_text(encoding="utf-8"))
                for node in ast.walk(tree):
                    if not isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
                        continue
                    for dec_name in _decorator_names(node):
                        if dec_name != expected_dir:
                            rel = step_file.relative_to(root)
                            violations.append(
                                f"{rel}: @{dec_name} decorator found in {expected_dir}/ directory"
                            )

        # Assert
        assert violations == [], (
            "Step decorators must match their directory (@given in given/, @when in when/, @then in then/):\n"
            + "\n".join(f"  - {v}" for v in violations)
        )
