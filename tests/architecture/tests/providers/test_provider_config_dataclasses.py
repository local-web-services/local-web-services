"""Architecture test: config and policy classes must be dataclasses."""

from __future__ import annotations

import ast
from pathlib import Path

SRC_DIR = Path(__file__).parent.parent.parent.parent.parent / "src" / "lws"
PROVIDERS_DIR = SRC_DIR / "providers"
INTERFACES_DIR = SRC_DIR / "interfaces"


def _parse_file(filepath: Path) -> ast.Module:
    return ast.parse(filepath.read_text())


def _has_decorator(cls: ast.ClassDef, name: str) -> bool:
    for d in cls.decorator_list:
        if isinstance(d, ast.Name) and d.id == name:
            return True
        if isinstance(d, ast.Attribute) and d.attr == name:
            return True
        if isinstance(d, ast.Call):
            func = d.func
            if isinstance(func, ast.Name) and func.id == name:
                return True
            if isinstance(func, ast.Attribute) and func.attr == name:
                return True
    return False


def _find_config_classes(tree: ast.Module) -> list[ast.ClassDef]:
    """Find classes ending in Config or Policy."""
    return [
        node
        for node in ast.iter_child_nodes(tree)
        if isinstance(node, ast.ClassDef)
        and (node.name.endswith("Config") or node.name.endswith("Policy"))
    ]


def _collect_all_python_files() -> list[Path]:
    """Collect all Python files from providers and interfaces directories."""
    files = []
    for py_file in sorted(PROVIDERS_DIR.rglob("*.py")):
        if py_file.name != "__init__.py":
            files.append(py_file)
    for py_file in sorted(INTERFACES_DIR.rglob("*.py")):
        if py_file.name != "__init__.py":
            files.append(py_file)
    return files


class TestProviderConfigDataclasses:
    def test_config_classes_are_dataclasses(self):
        """All classes ending in Config or Policy must use @dataclass."""
        violations = []
        for py_file in _collect_all_python_files():
            tree = _parse_file(py_file)
            config_classes = _find_config_classes(tree)
            for cls in config_classes:
                if not _has_decorator(cls, "dataclass"):
                    rel = py_file.relative_to(SRC_DIR)
                    violations.append(f"{rel}: class '{cls.name}' must use @dataclass decorator")

        assert violations == [], "Config/Policy dataclass violations:\n" + "\n".join(
            f"  - {v}" for v in violations
        )

    def test_config_classes_exist(self):
        """At least some config classes must exist in the codebase."""
        all_config_classes = []
        for py_file in _collect_all_python_files():
            tree = _parse_file(py_file)
            config_classes = _find_config_classes(tree)
            for cls in config_classes:
                rel = py_file.relative_to(SRC_DIR)
                all_config_classes.append(f"{rel}:{cls.name}")

        assert len(all_config_classes) >= 10, (
            f"Expected at least 10 Config/Policy classes, found {len(all_config_classes)}: "
            + ", ".join(all_config_classes)
        )

    def test_config_class_naming_convention(self):
        """Config/Policy classes must follow PascalCase naming."""
        violations = []
        for py_file in _collect_all_python_files():
            tree = _parse_file(py_file)
            config_classes = _find_config_classes(tree)
            for cls in config_classes:
                # PascalCase: starts with uppercase, no underscores
                if not cls.name[0].isupper():
                    rel = py_file.relative_to(SRC_DIR)
                    violations.append(f"{rel}: class '{cls.name}' must use PascalCase")
                if "_" in cls.name:
                    rel = py_file.relative_to(SRC_DIR)
                    violations.append(f"{rel}: class '{cls.name}' must not contain underscores")

        assert violations == [], "Config/Policy naming violations:\n" + "\n".join(
            f"  - {v}" for v in violations
        )
