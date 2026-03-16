"""Architecture test: service port keys must be consistent across CDK and Terraform modes.

Prevents regressions where Terraform mode uses internal names (e.g. ``"cognito"``,
``"eventbridge"``) while the CLI and CDK mode expect AWS service names
(``"cognito-idp"``, ``"events"``).
"""

from __future__ import annotations

import ast
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent.parent.parent
LDK_PY = REPO_ROOT / "src" / "lws" / "cli" / "ldk.py"


def _extract_dict_keys(source: str, func_name: str, var_name: str) -> set[str]:
    """Extract string keys from a dict literal assigned to *var_name* inside *func_name*."""
    tree = ast.parse(source)
    for node in ast.walk(tree):
        if not isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
            continue
        if node.name != func_name:
            continue
        for child in ast.walk(node):
            if isinstance(child, ast.Assign):
                for target in child.targets:
                    if isinstance(target, ast.Name) and target.id == var_name:
                        if isinstance(child.value, ast.Dict):
                            return {
                                k.value
                                for k in child.value.keys
                                if isinstance(k, ast.Constant) and isinstance(k.value, str)
                            }
    return set()


class TestServiceNameConsistency:
    def test_terraform_ports_match_cdk_ports(self):
        """Service keys in _create_terraform_providers must be a superset of _service_ports."""
        # Arrange
        source = LDK_PY.read_text()
        expected_cdk_keys = _extract_dict_keys(source, "_service_ports", "return")

        # Act
        actual_terraform_keys = _extract_dict_keys(source, "_create_terraform_providers", "ports")

        # Assert
        missing = expected_cdk_keys - actual_terraform_keys
        assert missing == set(), (
            "Terraform ports dict is missing service keys that CDK mode uses:\n"
            + "\n".join(f"  - {k}" for k in sorted(missing))
            + "\nBoth modes must use the same AWS service names (e.g. 'events' not 'eventbridge')."
        )

    def test_terraform_ports_use_aws_service_names(self):
        """Terraform ports must use AWS CLI service names, not internal provider names."""
        # Arrange
        source = LDK_PY.read_text()
        forbidden_internal_names = {"cognito", "eventbridge"}

        # Act
        actual_keys = _extract_dict_keys(source, "_create_terraform_providers", "ports")

        # Assert
        bad_keys = actual_keys & forbidden_internal_names
        assert (
            bad_keys == set()
        ), "Terraform ports dict uses internal names instead of AWS service names:\n" + "\n".join(
            f"  - '{k}' (should be the AWS CLI service name)" for k in sorted(bad_keys)
        )
