"""Architecture test: CLI commands using resolve_resource must have fallback handling.

Prevents regressions where CLI commands call ``resolve_resource()`` and then
``exit_with_error()`` on failure, which makes them unusable in Terraform mode
where resource metadata is not pre-populated.

The correct pattern is::

    try:
        resource = await client.resolve_resource(service, name)
        value = resource.get("key", "default")
    except Exception:
        value = "default"

The incorrect pattern (calling exit_with_error in except) makes the command
fail hard instead of falling back to a sensible default.
"""

from __future__ import annotations

import ast
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent.parent.parent
CLI_SERVICES_DIR = REPO_ROOT / "src" / "lws" / "cli" / "services"

EXCLUDED_MODULES = {"__init__", "client"}


def _try_has_resolve(try_node: ast.Try) -> bool:
    """Return True if the try body calls resolve_resource."""
    for node in ast.walk(try_node):
        if isinstance(node, ast.Attribute) and node.attr == "resolve_resource":
            return True
    return False


def _handler_calls_exit(handler: ast.ExceptHandler) -> bool:
    """Return True if the handler calls exit_with_error."""
    for node in ast.walk(handler):
        if (
            isinstance(node, ast.Call)
            and isinstance(node.func, ast.Name)
            and node.func.id == "exit_with_error"
        ):
            return True
    return False


def _find_exit_after_resolve(source: str, filepath: Path) -> list[str]:
    """Find functions where resolve_resource failure calls exit_with_error."""
    violations: list[str] = []
    try:
        tree = ast.parse(source)
    except SyntaxError:
        return violations

    for node in ast.walk(tree):
        if not isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
            continue
        for child in ast.walk(node):
            if not isinstance(child, ast.Try) or not _try_has_resolve(child):
                continue
            for handler in child.handlers:
                if _handler_calls_exit(handler):
                    violations.append(
                        f"{filepath}:{handler.lineno} - {node.name}() calls "
                        f"exit_with_error after resolve_resource failure "
                        f"(should fall back to a default value)"
                    )
    return violations


class TestCliResolveResourceFallback:
    def test_no_exit_on_resolve_failure(self):
        """CLI commands must not call exit_with_error when resolve_resource fails."""
        # Arrange / Act
        violations = []
        for py_file in sorted(CLI_SERVICES_DIR.glob("*.py")):
            if py_file.stem in EXCLUDED_MODULES:
                continue
            violations.extend(_find_exit_after_resolve(py_file.read_text(), py_file))

        # Assert
        assert violations == [], (
            "CLI commands call exit_with_error after resolve_resource failure.\n"
            "In Terraform mode, resource metadata is not pre-populated, so\n"
            "resolve_resource will always fail. Use a try/except fallback instead:\n\n"
            + "\n".join(f"  - {v}" for v in violations)
        )
