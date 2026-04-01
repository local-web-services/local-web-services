"""Architecture test: Given step files that call create_queue must wrap it in try/except."""

from __future__ import annotations

import ast

from lws_arch_tests._root import project_root
from lws_arch_tests._step_dirs import find_step_service_dirs


def _is_create_queue_call(node: ast.AST) -> bool:
    return (
        isinstance(node, ast.Call)
        and isinstance(node.func, ast.Attribute)
        and node.func.attr == "create_queue"
    )


def _create_queue_lines_inside_try(tree: ast.AST) -> set[int]:
    safe: set[int] = set()
    for node in ast.walk(tree):
        if isinstance(node, ast.Try):
            for child in ast.walk(node):
                if _is_create_queue_call(child):
                    safe.add(child.lineno)
    return safe


def _unprotected_create_queue_lines(tree: ast.AST) -> list[int]:
    safe = _create_queue_lines_inside_try(tree)
    return [
        node.lineno
        for node in ast.walk(tree)
        if _is_create_queue_call(node) and node.lineno not in safe
    ]


class TestGivenStepsIdempotentQueueCreation:
    def test_create_queue_calls_are_wrapped_in_try_except(self):
        """Given step files that call create_queue must wrap it in try/except.

        SQS raises QueueAlreadyExists on duplicate creation. Given steps often
        run after a Background step that already created the queue, so bare
        create_queue calls cause non-deterministic test failures.
        """
        # Arrange
        root = project_root()
        violations = []

        # Act
        for service_dir in find_step_service_dirs(root):
            given_dir = service_dir / "given"
            if not given_dir.exists():
                continue
            for path in sorted(given_dir.glob("*.py")):
                if path.name == "__init__.py":
                    continue
                tree = ast.parse(path.read_text())
                bad_lines = _unprotected_create_queue_lines(tree)
                if bad_lines:
                    rel = path.relative_to(root)
                    violations.append(f"{rel} (lines {bad_lines})")

        # Assert
        assert violations == [], (
            "Given step files must wrap create_queue calls in try/except "
            "(SQS raises QueueAlreadyExists if the queue already exists):\n"
            + "\n".join(f"  - {v}" for v in violations)
        )
