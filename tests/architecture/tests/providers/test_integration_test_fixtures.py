"""Architecture test: integration HTTP tests must follow the fixture pattern."""

from __future__ import annotations

import ast
import re
from pathlib import Path

INTEGRATION_DIR = Path(__file__).parent.parent.parent.parent.parent / "tests" / "integration"


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
        # Handle @pytest.fixture
        if isinstance(d, ast.Attribute) and d.attr == "fixture":
            if isinstance(d.value, ast.Name) and d.value.id == "pytest":
                return name == "fixture"
        # Handle @pytest.fixture(...)
        if isinstance(d, ast.Call):
            func = d.func
            if isinstance(func, ast.Attribute) and func.attr == "fixture":
                if isinstance(func.value, ast.Name) and func.value.id == "pytest":
                    return name == "fixture"
    return False


def _get_top_level_functions(tree: ast.Module) -> list[ast.FunctionDef | ast.AsyncFunctionDef]:
    return [
        node
        for node in ast.iter_child_nodes(tree)
        if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef))
    ]


def _get_fixtures(tree: ast.Module) -> dict[str, ast.FunctionDef | ast.AsyncFunctionDef]:
    fixtures = {}
    for func in _get_top_level_functions(tree):
        if _has_decorator(func, "fixture"):
            fixtures[func.name] = func
    return fixtures


class TestIntegrationTestFixtures:
    def test_http_operations_files_exist(self):
        """At least 7 HTTP operations test files must exist."""
        files = sorted(INTEGRATION_DIR.glob("test_*_http_operations.py"))
        assert len(files) >= 7, (
            f"Expected at least 7 test_*_http_operations.py files, found {len(files)}: "
            + ", ".join(f.name for f in files)
        )

    def test_each_file_has_provider_fixture(self):
        """Each HTTP operations test must have an async 'provider' fixture."""
        violations = []
        for path in sorted(INTEGRATION_DIR.glob("test_*_http_operations.py")):
            tree = _parse_file(path)
            fixtures = _get_fixtures(tree)
            if "provider" not in fixtures:
                violations.append(f"{path.name}: missing 'provider' fixture")
                continue
            provider_fixture = fixtures["provider"]
            if not isinstance(provider_fixture, ast.AsyncFunctionDef):
                violations.append(f"{path.name}: 'provider' fixture must be async")

        assert violations == [], "Provider fixture violations:\n" + "\n".join(
            f"  - {v}" for v in violations
        )

    def test_each_file_has_app_fixture(self):
        """Each HTTP operations test must have an 'app' fixture."""
        violations = []
        for path in sorted(INTEGRATION_DIR.glob("test_*_http_operations.py")):
            tree = _parse_file(path)
            fixtures = _get_fixtures(tree)
            if "app" not in fixtures:
                violations.append(f"{path.name}: missing 'app' fixture")
                continue
            app_fixture = fixtures["app"]
            # app fixture should take provider as parameter
            arg_names = [a.arg for a in app_fixture.args.args]
            if "provider" not in arg_names:
                violations.append(f"{path.name}: 'app' fixture must accept 'provider' parameter")

        assert violations == [], "App fixture violations:\n" + "\n".join(
            f"  - {v}" for v in violations
        )

    def test_each_file_has_client_fixture(self):
        """Each HTTP operations test must have an async 'client' fixture."""
        violations = []
        for path in sorted(INTEGRATION_DIR.glob("test_*_http_operations.py")):
            tree = _parse_file(path)
            fixtures = _get_fixtures(tree)
            if "client" not in fixtures:
                violations.append(f"{path.name}: missing 'client' fixture")
                continue
            client_fixture = fixtures["client"]
            if not isinstance(client_fixture, ast.AsyncFunctionDef):
                violations.append(f"{path.name}: 'client' fixture must be async")
            arg_names = [a.arg for a in client_fixture.args.args]
            if "app" not in arg_names:
                violations.append(f"{path.name}: 'client' fixture must accept 'app' parameter")

        assert violations == [], "Client fixture violations:\n" + "\n".join(
            f"  - {v}" for v in violations
        )

    def test_each_file_has_one_test_class_with_correct_name(self):
        """Each file must have exactly one class matching Test*HttpOperations."""
        violations = []
        for path in sorted(INTEGRATION_DIR.glob("test_*_http_operations.py")):
            tree = _parse_file(path)
            classes = _find_classes(tree)
            test_classes = [c for c in classes if c.name.startswith("Test")]

            if len(test_classes) != 1:
                violations.append(
                    f"{path.name}: expected 1 test class, found {len(test_classes)}: "
                    + ", ".join(c.name for c in test_classes)
                )
                continue

            cls_name = test_classes[0].name
            if not re.match(r"Test\w+HttpOperations$", cls_name):
                violations.append(
                    f"{path.name}: class '{cls_name}' must match pattern Test*HttpOperations"
                )

        assert violations == [], "Test class naming violations:\n" + "\n".join(
            f"  - {v}" for v in violations
        )

    def test_provider_fixture_has_start_and_stop(self):
        """Provider fixture must call await p.start() and await p.stop()."""
        violations = []
        for path in sorted(INTEGRATION_DIR.glob("test_*_http_operations.py")):
            source = path.read_text()
            tree = _parse_file(path)
            fixtures = _get_fixtures(tree)
            if "provider" not in fixtures:
                continue
            provider_func = fixtures["provider"]

            # Get the source lines for this fixture
            start_line = provider_func.lineno - 1
            end_line = provider_func.end_lineno
            fixture_source = "\n".join(source.splitlines()[start_line:end_line])

            has_start = ".start()" in fixture_source
            has_stop = ".stop()" in fixture_source

            if not has_start:
                violations.append(f"{path.name}: provider fixture must call .start()")
            if not has_stop:
                violations.append(f"{path.name}: provider fixture must call .stop()")

        assert violations == [], "Provider fixture lifecycle violations:\n" + "\n".join(
            f"  - {v}" for v in violations
        )
