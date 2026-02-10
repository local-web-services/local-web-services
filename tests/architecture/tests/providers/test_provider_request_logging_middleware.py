"""Architecture test: all provider routes use RequestLoggingMiddleware.

Ensures that every provider's `create_*_app()` function adds the
RequestLoggingMiddleware so all HTTP requests are logged consistently.
"""

from __future__ import annotations

import ast
from pathlib import Path


class TestProviderRequestLoggingMiddleware:
    """Enforce that all provider routes use RequestLoggingMiddleware."""

    def test_all_provider_routes_have_logging_middleware(self):
        """All create_*_app functions must add RequestLoggingMiddleware."""
        violations = []
        providers_dir = Path("src/lws/providers")

        # Find all routes.py files
        for routes_file in providers_dir.glob("*/routes.py"):
            service_name = routes_file.parent.name

            # Skip ECS - it uses ServiceManager pattern, not HTTP routes
            if service_name == "ecs":
                continue

            content = routes_file.read_text()
            tree = ast.parse(content)

            # Find create_*_app function
            create_app_func = None
            for node in ast.walk(tree):
                if (
                    isinstance(node, ast.FunctionDef)
                    and node.name.startswith("create_")
                    and node.name.endswith("_app")
                ):
                    create_app_func = node
                    break

            if create_app_func is None:
                violations.append(f"{routes_file}: No create_*_app function found")
                continue

            # Check that RequestLoggingMiddleware is imported
            has_middleware_import = "RequestLoggingMiddleware" in content

            if not has_middleware_import:
                violations.append(f"{routes_file}: RequestLoggingMiddleware not imported")
                continue

            # Check that add_middleware is called with RequestLoggingMiddleware
            has_add_middleware = self._has_middleware_call(create_app_func)

            if not has_add_middleware:
                violations.append(
                    f"{routes_file}: {create_app_func.name} does not call "
                    f"app.add_middleware(RequestLoggingMiddleware, ...)"
                )

        assert violations == [], (
            "RequestLoggingMiddleware pattern violations found:\n"
            + "\n".join(f"  - {v}" for v in violations)
            + "\n\nAll provider routes must add RequestLoggingMiddleware to ensure "
            "consistent request logging for both CLI and GUI."
        )

    def _has_middleware_call(self, func_node: ast.FunctionDef) -> bool:
        """Check if function body contains app.add_middleware(RequestLoggingMiddleware, ...)."""
        for node in ast.walk(func_node):
            if isinstance(node, ast.Expr) and isinstance(node.value, ast.Call):
                call = node.value
                # Check for app.add_middleware
                if (
                    isinstance(call.func, ast.Attribute)
                    and call.func.attr == "add_middleware"
                    and isinstance(call.func.value, ast.Name)
                    and call.func.value.id == "app"
                ):
                    # Check first argument is RequestLoggingMiddleware
                    if call.args and isinstance(call.args[0], ast.Name):
                        if call.args[0].id == "RequestLoggingMiddleware":
                            return True
        return False
