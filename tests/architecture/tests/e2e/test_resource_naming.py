"""Architecture test: e2e tests must use resource names prefixed with 'e2e-' or '/e2e/'."""

from __future__ import annotations

import ast
from pathlib import Path

E2E_DIR = Path(__file__).parent.parent.parent.parent / "e2e"

# Variable names containing any of these keywords are considered resource names.
RESOURCE_KEYWORDS = frozenset(
    {
        "name",
        "bucket",
        "queue",
        "topic",
        "table",
        "param",
        "key",
        "pool",
        "bus",
        "machine",
        "secret",
    }
)


def _has_resource_keyword(var_name: str) -> bool:
    """Return True if the variable name contains a resource keyword."""
    lower = var_name.lower()
    return any(kw in lower for kw in RESOURCE_KEYWORDS)


def _check_resource_names(filepath: Path) -> list[str]:
    """Return violation descriptions for resource name assignments missing the e2e prefix."""
    tree = ast.parse(filepath.read_text())
    violations = []
    for node in ast.walk(tree):
        # Only check simple assignments: var = "literal"
        if not isinstance(node, ast.Assign):
            continue
        if len(node.targets) != 1:
            continue
        target = node.targets[0]
        if not isinstance(target, ast.Name):
            continue
        if not isinstance(node.value, ast.Constant):
            continue
        if not isinstance(node.value.value, str):
            continue

        var_name = target.id
        value = node.value.value

        if not _has_resource_keyword(var_name):
            continue

        if value.startswith("e2e-") or value.startswith("/e2e/"):
            continue

        rel = filepath.relative_to(E2E_DIR)
        violations.append(f"{rel}: {var_name} = {value!r} (missing e2e- or /e2e/ prefix)")

    return violations


# Ratchet: number of known violations. Lower this as violations are fixed.
# Do NOT increase this number -- fix new violations instead.
_RATCHET_THRESHOLD = 7


class TestResourceNaming:
    def test_e2e_resource_names_have_prefix(self):
        violations = []
        for path in sorted(E2E_DIR.rglob("test_*.py")):
            violations.extend(_check_resource_names(path))

        assert len(violations) <= _RATCHET_THRESHOLD, (
            f"E2E resource naming violations ({len(violations)}) exceed "
            f"ratchet threshold ({_RATCHET_THRESHOLD}).\n"
            "New resource names must start with 'e2e-' or '/e2e/':\n"
            + "\n".join(f"  - {v}" for v in violations)
        )
