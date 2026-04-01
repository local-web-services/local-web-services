"""Architecture test: each file in given/when/then must define exactly one step."""
from __future__ import annotations

import ast

from lws_arch_tests._root import project_root
from lws_arch_tests._step_dirs import (
    STEP_DECORATOR_NAMES,
    find_step_service_dirs,
    iter_step_files,
)


def _count_step_functions(tree: ast.Module) -> int:
    count = 0
    for node in ast.walk(tree):
        if not isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
            continue
        for dec in node.decorator_list:
            if isinstance(dec, ast.Call) and isinstance(dec.func, ast.Name):
                if dec.func.id in STEP_DECORATOR_NAMES:
                    count += 1
                    break
    return count


class TestOneStepPerFile:
    def test_one_step_per_file(self):
        # Arrange
        root = project_root()
        violations: list[str] = []

        # Act
        for service_dir in find_step_service_dirs(root):
            for step_file in iter_step_files(service_dir):
                tree = ast.parse(step_file.read_text(encoding="utf-8"))
                count = _count_step_functions(tree)
                if count != 1:
                    rel = step_file.relative_to(root)
                    violations.append(
                        f"{rel}: {count} step function(s) (expected exactly 1)"
                    )

        # Assert
        assert violations == [], (
            "Each file in given/when/then must define exactly one @given/@when/@then function:\n"
            + "\n".join(f"  - {v}" for v in violations)
        )
