"""Architecture test: every CLI service module must be registered in lws.py."""

from __future__ import annotations

import ast
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent.parent.parent
LWS_CLI_ENTRY = REPO_ROOT / "src" / "lws" / "cli" / "lws.py"
CLI_SERVICES_DIR = REPO_ROOT / "src" / "lws" / "cli" / "services"

# Modules that are shared utilities, not service registrations.
EXCLUDED_MODULES = {"__init__", "client", "_shared_commands"}


def _service_module_names() -> list[str]:
    """Return sorted list of service module names from the services directory."""
    return sorted(p.stem for p in CLI_SERVICES_DIR.glob("*.py") if p.stem not in EXCLUDED_MODULES)


def _registered_module_names() -> set[str]:
    """Parse lws.py to find all ``from lws.cli.services.<module> import ...`` statements."""
    tree = ast.parse(LWS_CLI_ENTRY.read_text())
    registered = set()
    for node in ast.walk(tree):
        if (
            isinstance(node, ast.ImportFrom)
            and node.module
            and node.module.startswith("lws.cli.services.")
        ):
            module_name = node.module.split(".")[-1]
            registered.add(module_name)
    return registered


class TestCliServiceRegistration:
    def test_all_service_modules_are_registered(self):
        """Every service module in cli/services/ must be imported in lws.py."""
        registered = _registered_module_names()
        unregistered = [name for name in _service_module_names() if name not in registered]

        assert unregistered == [], "CLI service modules not registered in lws.py:\n" + "\n".join(
            f"  - {m}.py" for m in unregistered
        )
