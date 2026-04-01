"""Given: the "ssm" "parameter" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "ssm" "parameter" did not exist')
def parameter_does_not_exist():
    """No-op: fresh state has no parameters."""
