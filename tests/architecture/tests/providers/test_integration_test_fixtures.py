"""Architecture test: integration service conftest.py files must follow the fixture pattern."""

from __future__ import annotations

import ast
from pathlib import Path

INTEGRATION_DIR = Path(__file__).parent.parent.parent.parent.parent / "tests" / "integration"


def _parse_file(filepath: Path) -> ast.Module:
    return ast.parse(filepath.read_text())


def _has_decorator(node: ast.FunctionDef | ast.AsyncFunctionDef, name: str) -> bool:
    for d in node.decorator_list:
        if isinstance(d, ast.Name) and d.id == name:
            return True
        if isinstance(d, ast.Attribute) and d.attr == name:
            return True
        if isinstance(d, ast.Attribute) and d.attr == "fixture":
            if isinstance(d.value, ast.Name) and d.value.id == "pytest":
                return name == "fixture"
        if isinstance(d, ast.Call):
            func = d.func
            if isinstance(func, ast.Attribute) and func.attr == "fixture":
                if isinstance(func.value, ast.Name) and func.value.id == "pytest":
                    return name == "fixture"
    return False


def _get_top_level_functions(
    tree: ast.Module,
) -> list[ast.FunctionDef | ast.AsyncFunctionDef]:
    return [
        node
        for node in ast.iter_child_nodes(tree)
        if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef))
    ]


def _get_fixtures(
    tree: ast.Module,
) -> dict[str, ast.FunctionDef | ast.AsyncFunctionDef]:
    fixtures = {}
    for func in _get_top_level_functions(tree):
        if _has_decorator(func, "fixture"):
            fixtures[func.name] = func
    return fixtures


def _service_conftest_files() -> list[Path]:
    """Find all conftest.py files in service subdirectories of integration/."""
    return sorted(
        p for p in INTEGRATION_DIR.glob("*/conftest.py") if p.parent.name != "__pycache__"
    )


class TestIntegrationServiceConftestFiles:
    def test_service_conftest_files_exist(self):
        """At least 7 service directories must have a conftest.py."""
        # Arrange
        expected_min_count = 7

        # Act
        files = _service_conftest_files()
        actual_count = len(files)

        # Assert
        assert actual_count >= expected_min_count, (
            f"Expected at least {expected_min_count} service conftest.py files, "
            f"found {actual_count}: " + ", ".join(f.parent.name for f in files)
        )

    def test_each_conftest_has_provider_fixture(self):
        """Each service conftest must have an async 'provider' fixture."""
        violations = []
        for path in _service_conftest_files():
            tree = _parse_file(path)
            fixtures = _get_fixtures(tree)
            if "provider" not in fixtures:
                violations.append(f"{path.parent.name}/conftest.py: missing 'provider' fixture")
                continue
            provider_fixture = fixtures["provider"]
            if not isinstance(provider_fixture, ast.AsyncFunctionDef):
                violations.append(
                    f"{path.parent.name}/conftest.py: " "'provider' fixture must be async"
                )

        assert violations == [], "Provider fixture violations:\n" + "\n".join(
            f"  - {v}" for v in violations
        )

    def test_each_conftest_has_app_fixture(self):
        """Each service conftest must have an 'app' fixture."""
        violations = []
        for path in _service_conftest_files():
            tree = _parse_file(path)
            fixtures = _get_fixtures(tree)
            if "app" not in fixtures:
                violations.append(f"{path.parent.name}/conftest.py: missing 'app' fixture")
                continue
            app_fixture = fixtures["app"]
            arg_names = [a.arg for a in app_fixture.args.args]
            if "provider" not in arg_names:
                violations.append(
                    f"{path.parent.name}/conftest.py: "
                    "'app' fixture must accept 'provider' parameter"
                )

        assert violations == [], "App fixture violations:\n" + "\n".join(
            f"  - {v}" for v in violations
        )

    def test_each_conftest_has_client_fixture(self):
        """Each service conftest must have an async 'client' fixture."""
        violations = []
        for path in _service_conftest_files():
            tree = _parse_file(path)
            fixtures = _get_fixtures(tree)
            if "client" not in fixtures:
                violations.append(f"{path.parent.name}/conftest.py: missing 'client' fixture")
                continue
            client_fixture = fixtures["client"]
            if not isinstance(client_fixture, ast.AsyncFunctionDef):
                violations.append(
                    f"{path.parent.name}/conftest.py: " "'client' fixture must be async"
                )
            arg_names = [a.arg for a in client_fixture.args.args]
            if "app" not in arg_names:
                violations.append(
                    f"{path.parent.name}/conftest.py: "
                    "'client' fixture must accept 'app' parameter"
                )

        assert violations == [], "Client fixture violations:\n" + "\n".join(
            f"  - {v}" for v in violations
        )

    def test_provider_fixture_has_start_and_stop(self):
        """Provider fixture must call .start() and .stop()."""
        violations = []
        for path in _service_conftest_files():
            source = path.read_text()
            tree = _parse_file(path)
            fixtures = _get_fixtures(tree)
            if "provider" not in fixtures:
                continue
            provider_func = fixtures["provider"]

            start_line = provider_func.lineno - 1
            end_line = provider_func.end_lineno
            fixture_source = "\n".join(source.splitlines()[start_line:end_line])

            # Stateless providers that yield None don't need start/stop
            if "yield None" in fixture_source:
                continue

            has_start = ".start()" in fixture_source
            has_stop = ".stop()" in fixture_source

            svc = path.parent.name
            if not has_start:
                violations.append(f"{svc}/conftest.py: provider fixture must call .start()")
            if not has_stop:
                violations.append(f"{svc}/conftest.py: provider fixture must call .stop()")

        assert violations == [], "Provider fixture lifecycle violations:\n" + "\n".join(
            f"  - {v}" for v in violations
        )
