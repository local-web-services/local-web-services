"""Given: the "ssm" "parameter" did not already exist or has been deleted"""

from __future__ import annotations

from pytest_bdd import given


@given('the "ssm" "parameter" did not already exist or has been deleted')
def parameter_not_already_exist_or_deleted():
    """No-op: fresh state has no parameters."""
