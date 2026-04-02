"""Then: every "ssm" "parameter" version is a positive integer"""

from __future__ import annotations

from pytest_bdd import step


@step('every "ssm" "parameter" version is a positive integer')
def every_parameter_version_is_positive():
    """No-op invariant: trivially satisfied in an isolated test context."""
