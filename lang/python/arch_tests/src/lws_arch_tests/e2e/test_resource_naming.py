"""Architecture test: e2e tests must use resource names prefixed with 'e2e-' or '/e2e/'."""

from __future__ import annotations

import ast

from lws_arch_tests._root import project_root

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

_RATCHET_THRESHOLD = 0


def _has_resource_keyword(var_name: str) -> bool:
    lower = var_name.lower()
    return any(kw in lower for kw in RESOURCE_KEYWORDS)


def _check_resource_names(filepath, e2e_dir) -> list[str]:
    tree = ast.parse(filepath.read_text())
    violations = []
    for node in ast.walk(tree):
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
        rel = filepath.relative_to(e2e_dir)
        violations.append(f"{rel}: {var_name} = {value!r} (missing e2e- or /e2e/ prefix)")
    return violations


class TestResourceNaming:
    def test_e2e_resource_names_have_prefix(self):
        # Arrange
        e2e_dir = project_root() / "tests" / "e2e"
        violations = []

        # Act
        for path in sorted(e2e_dir.rglob("*.py")):
            if path.name == "__init__.py":
                continue
            violations.extend(_check_resource_names(path, e2e_dir))

        # Assert
        assert len(violations) <= _RATCHET_THRESHOLD, (
            f"E2E resource naming violations ({len(violations)}) exceed "
            f"ratchet threshold ({_RATCHET_THRESHOLD}).\n"
            "New resource names must start with 'e2e-' or '/e2e/':\n"
            + "\n".join(f"  - {v}" for v in violations)
        )
