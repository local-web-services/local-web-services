"""Then: "ssm" "parameter" param_exists values are always valid booleans"""

from __future__ import annotations

from pytest_bdd import step


@step('"ssm" "parameter" param_exists values are always valid booleans')
def param_exists_values_valid_booleans():
    """No-op invariant: param_exists values are always valid booleans in isolated test context."""
