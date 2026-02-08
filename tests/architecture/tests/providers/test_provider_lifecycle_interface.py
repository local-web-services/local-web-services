"""Architecture test: all providers must implement the Provider lifecycle interface."""

from __future__ import annotations

import ast
from pathlib import Path

PROVIDERS_DIR = Path(__file__).parent.parent.parent.parent.parent / "src" / "ldk" / "providers"

# Providers that follow the standard lifecycle pattern.
# apigateway and ecs are included because they also inherit from Provider.
EXPECTED_PROVIDERS = sorted(p.parent.name for p in PROVIDERS_DIR.glob("*/provider.py"))


def _parse_file(filepath: Path) -> ast.Module:
    return ast.parse(filepath.read_text())


def _find_classes(tree: ast.Module) -> list[ast.ClassDef]:
    return [node for node in ast.iter_child_nodes(tree) if isinstance(node, ast.ClassDef)]


def _has_decorator(node: ast.FunctionDef | ast.AsyncFunctionDef, name: str) -> bool:
    for d in node.decorator_list:
        if isinstance(d, ast.Name) and d.id == name:
            return True
        if isinstance(d, ast.Attribute) and d.attr == name:
            return True
    return False


def _get_methods(cls: ast.ClassDef) -> dict[str, ast.FunctionDef | ast.AsyncFunctionDef]:
    methods = {}
    for node in ast.iter_child_nodes(cls):
        if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
            methods[node.name] = node
    return methods


def _get_return_annotation_name(node: ast.FunctionDef | ast.AsyncFunctionDef) -> str | None:
    ann = node.returns
    if isinstance(ann, ast.Name):
        return ann.id
    if isinstance(ann, ast.Constant):
        return str(ann.value)
    return None


def _find_provider_class(tree: ast.Module) -> ast.ClassDef | None:
    """Find the main provider class (inherits from Provider or a sub-interface)."""
    for cls in _find_classes(tree):
        for base in cls.bases:
            base_name = None
            if isinstance(base, ast.Name):
                base_name = base.id
            elif isinstance(base, ast.Attribute):
                base_name = base.attr
            if base_name and base_name in (
                "Provider",
                "IKeyValueStore",
                "IQueue",
                "IObjectStore",
                "ICompute",
                "IEventBus",
                "IStateMachine",
            ):
                return cls
    return None


class TestProviderLifecycleInterface:
    def test_all_expected_provider_directories_exist(self):
        actual = sorted(p.parent.name for p in PROVIDERS_DIR.glob("*/provider.py"))
        assert (
            len(actual) >= 7
        ), f"Expected at least 7 provider directories, found {len(actual)}: {actual}"

    def test_each_provider_has_name_property(self):
        violations = []
        for provider_dir in sorted(PROVIDERS_DIR.iterdir()):
            provider_file = provider_dir / "provider.py"
            if not provider_file.exists():
                continue
            tree = _parse_file(provider_file)
            cls = _find_provider_class(tree)
            if cls is None:
                violations.append(f"{provider_dir.name}: no provider class found")
                continue
            methods = _get_methods(cls)
            if "name" not in methods:
                violations.append(f"{provider_dir.name}/{cls.name}: missing 'name' property")
                continue
            name_method = methods["name"]
            if not _has_decorator(name_method, "property"):
                violations.append(f"{provider_dir.name}/{cls.name}: 'name' must be a @property")
            if _get_return_annotation_name(name_method) != "str":
                violations.append(f"{provider_dir.name}/{cls.name}: 'name' must return str")

        assert violations == [], "Provider name property violations:\n" + "\n".join(
            f"  - {v}" for v in violations
        )

    def test_each_provider_has_async_start(self):
        violations = []
        for provider_dir in sorted(PROVIDERS_DIR.iterdir()):
            provider_file = provider_dir / "provider.py"
            if not provider_file.exists():
                continue
            tree = _parse_file(provider_file)
            cls = _find_provider_class(tree)
            if cls is None:
                continue
            methods = _get_methods(cls)
            if "start" not in methods:
                violations.append(f"{provider_dir.name}/{cls.name}: missing 'start' method")
                continue
            start = methods["start"]
            if not isinstance(start, ast.AsyncFunctionDef):
                violations.append(f"{provider_dir.name}/{cls.name}: 'start' must be async")
            if _get_return_annotation_name(start) != "None":
                violations.append(f"{provider_dir.name}/{cls.name}: 'start' must return None")

        assert violations == [], "Provider start() violations:\n" + "\n".join(
            f"  - {v}" for v in violations
        )

    def test_each_provider_has_async_stop(self):
        violations = []
        for provider_dir in sorted(PROVIDERS_DIR.iterdir()):
            provider_file = provider_dir / "provider.py"
            if not provider_file.exists():
                continue
            tree = _parse_file(provider_file)
            cls = _find_provider_class(tree)
            if cls is None:
                continue
            methods = _get_methods(cls)
            if "stop" not in methods:
                violations.append(f"{provider_dir.name}/{cls.name}: missing 'stop' method")
                continue
            stop = methods["stop"]
            if not isinstance(stop, ast.AsyncFunctionDef):
                violations.append(f"{provider_dir.name}/{cls.name}: 'stop' must be async")
            if _get_return_annotation_name(stop) != "None":
                violations.append(f"{provider_dir.name}/{cls.name}: 'stop' must return None")

        assert violations == [], "Provider stop() violations:\n" + "\n".join(
            f"  - {v}" for v in violations
        )

    def test_each_provider_has_async_health_check(self):
        violations = []
        for provider_dir in sorted(PROVIDERS_DIR.iterdir()):
            provider_file = provider_dir / "provider.py"
            if not provider_file.exists():
                continue
            tree = _parse_file(provider_file)
            cls = _find_provider_class(tree)
            if cls is None:
                continue
            methods = _get_methods(cls)
            if "health_check" not in methods:
                violations.append(f"{provider_dir.name}/{cls.name}: missing 'health_check' method")
                continue
            hc = methods["health_check"]
            if not isinstance(hc, ast.AsyncFunctionDef):
                violations.append(f"{provider_dir.name}/{cls.name}: 'health_check' must be async")
            if _get_return_annotation_name(hc) != "bool":
                violations.append(
                    f"{provider_dir.name}/{cls.name}: 'health_check' must return bool"
                )

        assert violations == [], "Provider health_check() violations:\n" + "\n".join(
            f"  - {v}" for v in violations
        )

    def test_provider_name_values_are_lowercase(self):
        """Verify that name property returns a lowercase string value."""
        violations = []
        for provider_dir in sorted(PROVIDERS_DIR.iterdir()):
            provider_file = provider_dir / "provider.py"
            if not provider_file.exists():
                continue
            tree = _parse_file(provider_file)
            cls = _find_provider_class(tree)
            if cls is None:
                continue
            methods = _get_methods(cls)
            if "name" not in methods:
                continue
            name_method = methods["name"]
            for node in ast.walk(name_method):
                if isinstance(node, ast.Return) and isinstance(node.value, ast.Constant):
                    value = node.value.value
                    if not isinstance(value, str):
                        vtype = type(value).__name__
                        violations.append(
                            f"{provider_dir.name}/{cls.name}: "
                            f"name must return a string, got {vtype}"
                        )
                    elif value != value.lower():
                        violations.append(
                            f"{provider_dir.name}/{cls.name}: name '{value}' must be lowercase"
                        )

        assert violations == [], "Provider name value violations:\n" + "\n".join(
            f"  - {v}" for v in violations
        )
