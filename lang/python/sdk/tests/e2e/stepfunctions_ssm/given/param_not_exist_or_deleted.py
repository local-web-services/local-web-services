"""Given: the "ssm" "parameter" did not exist or was "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "ssm" "parameter" did not exist or was "DELETED"')
def param_not_exist_or_deleted():
    """No-op: fresh state has no parameters."""
