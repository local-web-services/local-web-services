"""Architecture test: client.py must define exactly one PascalCaseTestClient class."""
from __future__ import annotations

import ast

from lws_arch_tests._root import project_root
from lws_arch_tests._step_dirs import find_step_service_dirs


def _to_class_name(dir_name: str) -> str:
    clean = dir_name.rstrip("_")
    parts = clean.split("_")
    return "".join(p.capitalize() for p in parts) + "TestClient"


class TestClientClassNaming:
    def test_client_class_naming(self):
        # Arrange
        root = project_root()
        violations: list[str] = []

        # Act
        for service_dir in find_step_service_dirs(root):
            client_py = service_dir / "client.py"
            if not client_py.exists():
                continue
            tree = ast.parse(client_py.read_text(encoding="utf-8"))
            classes = [n for n in tree.body if isinstance(n, ast.ClassDef)]
            rel = client_py.relative_to(root)

            if len(classes) != 1:
                violations.append(f"{rel}: expected 1 class, found {len(classes)}")
                continue

            expected = _to_class_name(service_dir.name)
            actual = classes[0].name
            if actual != expected:
                violations.append(
                    f"{rel}: class is '{actual}', expected '{expected}'"
                )

        # Assert
        assert violations == [], (
            "client.py class naming violations:\n"
            + "\n".join(f"  - {v}" for v in violations)
        )
