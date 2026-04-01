"""Given: the "ssm" "parameter" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "ssm" "parameter" did not exist')
def parameter_not_already_exist():
    """No-op: fresh state has no parameters."""
