"""Architecture test: providers with routes must have a create_*_app() factory."""

from __future__ import annotations

import ast
import re
from pathlib import Path

PROVIDERS_DIR = Path(__file__).parent.parent.parent.parent.parent / "src" / "lws" / "providers"

# Providers that are expected to have a routes.py with a create_*_app factory.
# apigateway has no routes.py (it builds routes dynamically).
# ecs uses build_ecs_router instead of the create_*_app pattern.
# lambda_runtime is not a provider (no provider.py).
EXCLUDED_PROVIDERS = {"apigateway", "ecs", "lambda_runtime"}


def _is_provider_dir(path: Path) -> bool:
    """A directory is a provider if it contains a provider.py file."""
    return path.is_dir() and (path / "provider.py").exists()


def _parse_file(filepath: Path) -> ast.Module:
    return ast.parse(filepath.read_text())


def _get_annotation_name(annotation: ast.expr | None) -> str | None:
    if isinstance(annotation, ast.Name):
        return annotation.id
    if isinstance(annotation, ast.Attribute):
        return annotation.attr
    if isinstance(annotation, ast.Subscript):
        return _get_annotation_name(annotation.value)
    return None


class TestProviderRoutesFactory:
    def test_every_provider_with_routes_has_create_app_factory(self):
        """Each provider's routes.py must contain a create_*_app function."""
        violations = []
        for provider_dir in sorted(PROVIDERS_DIR.iterdir()):
            if not _is_provider_dir(provider_dir):
                continue
            if provider_dir.name in EXCLUDED_PROVIDERS:
                continue
            routes_file = provider_dir / "routes.py"
            if not routes_file.exists():
                violations.append(f"{provider_dir.name}: missing routes.py")
                continue

            tree = _parse_file(routes_file)
            factory_funcs = [
                node
                for node in ast.iter_child_nodes(tree)
                if isinstance(node, ast.FunctionDef) and re.match(r"create_\w+_app$", node.name)
            ]

            if not factory_funcs:
                violations.append(
                    f"{provider_dir.name}/routes.py: no create_*_app factory function found"
                )

        assert violations == [], "Routes factory violations:\n" + "\n".join(
            f"  - {v}" for v in violations
        )

    def test_create_app_factory_returns_fastapi(self):
        """Each create_*_app function must have a FastAPI return annotation."""
        expected_return_type = "FastAPI"
        violations = []
        for provider_dir in sorted(PROVIDERS_DIR.iterdir()):
            if not _is_provider_dir(provider_dir):
                continue
            if provider_dir.name in EXCLUDED_PROVIDERS:
                continue
            routes_file = provider_dir / "routes.py"
            if not routes_file.exists():
                continue

            tree = _parse_file(routes_file)
            for node in ast.iter_child_nodes(tree):
                if isinstance(node, ast.FunctionDef) and re.match(r"create_\w+_app$", node.name):
                    actual_return_type = _get_annotation_name(node.returns)
                    if actual_return_type != expected_return_type:
                        violations.append(
                            f"{provider_dir.name}/routes.py: "
                            f"{node.name} must have return type "
                            f"{expected_return_type}, "
                            f"got {actual_return_type}"
                        )

        assert violations == [], "Routes factory return type violations:\n" + "\n".join(
            f"  - {v}" for v in violations
        )

    def test_create_app_factory_takes_provider_parameter(self):
        """Each create_*_app function must accept a provider/store parameter."""
        violations = []
        for provider_dir in sorted(PROVIDERS_DIR.iterdir()):
            if not _is_provider_dir(provider_dir):
                continue
            if provider_dir.name in EXCLUDED_PROVIDERS:
                continue
            routes_file = provider_dir / "routes.py"
            if not routes_file.exists():
                continue

            tree = _parse_file(routes_file)
            for node in ast.iter_child_nodes(tree):
                if isinstance(node, ast.FunctionDef) and re.match(r"create_\w+_app$", node.name):
                    args = node.args.args
                    if len(args) < 1:
                        violations.append(
                            f"{provider_dir.name}/routes.py: "
                            f"{node.name} must accept at least one parameter"
                        )
                        continue
                    first_arg = args[0]
                    if first_arg.annotation is None:
                        violations.append(
                            f"{provider_dir.name}/routes.py: "
                            f"{node.name} first parameter must have a type annotation"
                        )

        assert violations == [], "Routes factory parameter violations:\n" + "\n".join(
            f"  - {v}" for v in violations
        )

    def test_factory_function_name_matches_provider(self):
        """Factory function name must match pattern create_{provider}_app."""
        violations = []
        for provider_dir in sorted(PROVIDERS_DIR.iterdir()):
            if not _is_provider_dir(provider_dir):
                continue
            if provider_dir.name in EXCLUDED_PROVIDERS:
                continue
            routes_file = provider_dir / "routes.py"
            if not routes_file.exists():
                continue

            tree = _parse_file(routes_file)
            factory_funcs = [
                node
                for node in ast.iter_child_nodes(tree)
                if isinstance(node, ast.FunctionDef) and re.match(r"create_\w+_app$", node.name)
            ]

            for func in factory_funcs:
                expected_name = f"create_{provider_dir.name}_app"
                if func.name != expected_name:
                    violations.append(
                        f"{provider_dir.name}/routes.py: "
                        f"factory is '{func.name}', expected '{expected_name}'"
                    )

        assert violations == [], "Factory function naming violations:\n" + "\n".join(
            f"  - {v}" for v in violations
        )
