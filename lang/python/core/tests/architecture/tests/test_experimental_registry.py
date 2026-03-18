"""Architecture test: experimental registry entries must match real services and commands."""

from __future__ import annotations

import ast
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent.parent.parent
LWS_CLI_ENTRY = REPO_ROOT / "src" / "lws" / "cli" / "lws.py"


def _registered_service_names() -> set[str]:
    """Parse lws.py to find all service names passed to ``_add_service``."""
    tree = ast.parse(LWS_CLI_ENTRY.read_text())
    names: set[str] = set()
    for node in ast.walk(tree):
        if (
            isinstance(node, ast.Call)
            and isinstance(node.func, ast.Name)
            and node.func.id == "_add_service"
            and len(node.args) >= 2
            and isinstance(node.args[1], ast.Constant)
        ):
            names.add(node.args[1].value)
    return names


class TestExperimentalRegistry:
    def test_experimental_services_are_registered(self):
        """Every entry in EXPERIMENTAL_SERVICES must correspond to a real service in lws.py."""
        # Arrange
        from lws.cli.experimental import EXPERIMENTAL_SERVICES

        registered = _registered_service_names()

        # Act
        stale = sorted(s for s in EXPERIMENTAL_SERVICES if s not in registered)

        # Assert
        assert (
            stale == []
        ), "EXPERIMENTAL_SERVICES contains entries not registered in lws.py:\n" + "\n".join(
            f"  - {s}" for s in stale
        )

    def test_experimental_commands_are_registered(self):
        """Every entry in EXPERIMENTAL_COMMANDS must reference a registered service."""
        # Arrange
        from lws.cli.experimental import EXPERIMENTAL_COMMANDS

        registered = _registered_service_names()

        # Act
        stale = sorted(
            f"{svc} {cmd}" for svc, cmd in EXPERIMENTAL_COMMANDS if svc not in registered
        )

        # Assert
        assert (
            stale == []
        ), "EXPERIMENTAL_COMMANDS references services not registered in lws.py:\n" + "\n".join(
            f"  - {entry}" for entry in stale
        )
