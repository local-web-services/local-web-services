"""Architecture test: every lws CLI command must have corresponding e2e and integration tests.

Parses lws.py to discover all registered sub-commands via ``app.add_typer(..., name=...)``,
then parses each service module to discover ``@app.command("name")`` decorators, and
verifies that matching test files exist in both tests/e2e/ and tests/integration/.

Convention: test directories use the CLI sub-command name with hyphens replaced by
underscores (e.g. ``cognito-idp`` → ``cognito_idp``).
"""

from __future__ import annotations

import ast
import keyword
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent.parent.parent
LWS_CLI_ENTRY = REPO_ROOT / "src" / "lws" / "cli" / "lws.py"
CLI_SERVICES_DIR = REPO_ROOT / "src" / "lws" / "cli" / "services"
E2E_DIR = REPO_ROOT / "tests" / "e2e"
INTEGRATION_DIR = REPO_ROOT / "tests" / "integration"


def _discover_cli_services() -> dict[str, Path]:
    """Parse lws.py to discover {cli_name: service_module_path}.

    Looks for ``from lws.cli.services.<module> import app as <alias>``
    and ``app.add_typer(<alias>, name="<cli_name>")``.
    """
    tree = ast.parse(LWS_CLI_ENTRY.read_text())

    # Build alias -> module filename from imports
    alias_to_module: dict[str, str] = {}
    for node in ast.walk(tree):
        if (
            isinstance(node, ast.ImportFrom)
            and node.module
            and node.module.startswith("lws.cli.services.")
        ):
            module_name = node.module.split(".")[-1]
            for alias in node.names:
                if alias.asname:
                    alias_to_module[alias.asname] = f"{module_name}.py"

    # Build cli_name -> module path from add_typer calls
    result: dict[str, Path] = {}
    for node in ast.walk(tree):
        if not (
            isinstance(node, ast.Call)
            and isinstance(node.func, ast.Attribute)
            and node.func.attr == "add_typer"
            and node.args
            and isinstance(node.args[0], ast.Name)
        ):
            continue
        alias = node.args[0].id
        cli_name = None
        for kw in node.keywords:
            if kw.arg == "name" and isinstance(kw.value, ast.Constant):
                cli_name = kw.value.value
        if cli_name and alias in alias_to_module:
            result[cli_name] = CLI_SERVICES_DIR / alias_to_module[alias]

    return result


def _extract_commands(filepath: Path) -> list[str]:
    """Extract command names from @app.command("name") decorators in a CLI service file."""
    tree = ast.parse(filepath.read_text())
    commands = []
    for node in ast.walk(tree):
        if not isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
            continue
        for decorator in node.decorator_list:
            if (
                isinstance(decorator, ast.Call)
                and isinstance(decorator.func, ast.Attribute)
                and decorator.func.attr == "command"
                and decorator.args
                and isinstance(decorator.args[0], ast.Constant)
                and isinstance(decorator.args[0].value, str)
            ):
                commands.append(decorator.args[0].value)
    return commands


def _discover_all_commands() -> dict[str, list[str]]:
    """Return {cli_name: [command1, command2, ...]} for all services."""
    result = {}
    for cli_name, module_path in _discover_cli_services().items():
        if module_path.exists():
            commands = _extract_commands(module_path)
            if commands:
                result[cli_name] = sorted(commands)
    return result


def _test_dir_for_cli(cli_name: str) -> str:
    """Convert a CLI sub-command name to its test directory name.

    Convention: replace hyphens with underscores (valid Python package names).
    Python keywords get a trailing underscore per PEP 8.
    """
    name = cli_name.replace("-", "_")
    if keyword.iskeyword(name):
        name += "_"
    return name


def _command_to_filename(command: str) -> str:
    """Convert a CLI command name to its expected test filename.

    Example: "put-parameter" -> "test_put_parameter.py"
    """
    return f"test_{command.replace('-', '_')}.py"


ALL_COMMANDS = _discover_all_commands()


class TestE2eTestCoverage:
    """Verify every CLI command has an e2e test file."""

    def test_every_command_has_e2e_test(self):
        # Arrange
        missing = []
        for cli_name, commands in ALL_COMMANDS.items():
            test_dir = _test_dir_for_cli(cli_name)
            for command in commands:
                expected_file = E2E_DIR / test_dir / _command_to_filename(command)
                if not expected_file.exists():
                    missing.append(f"tests/e2e/{test_dir}/{_command_to_filename(command)}")

        # Assert
        assert (
            missing == []
        ), f"Missing e2e test files for {len(missing)} CLI commands:\n" + "\n".join(
            f"  - {m}" for m in sorted(missing)
        )


class TestIntegrationTestCoverage:
    """Verify every CLI command has an integration test file."""

    def test_every_command_has_integration_test(self):
        # Arrange
        missing = []
        for cli_name, commands in ALL_COMMANDS.items():
            test_dir = _test_dir_for_cli(cli_name)
            for command in commands:
                expected_file = INTEGRATION_DIR / test_dir / _command_to_filename(command)
                if not expected_file.exists():
                    missing.append(f"tests/integration/{test_dir}/{_command_to_filename(command)}")

        # Assert
        assert (
            missing == []
        ), f"Missing integration test files for {len(missing)} CLI commands:\n" + "\n".join(
            f"  - {m}" for m in sorted(missing)
        )
