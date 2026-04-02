"""Given: the "elasticache" "parameter group" was not "present" """

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" "parameter group" was not "present"')
def param_group_is_not_present():
    """No-op: fresh state has no parameter groups."""
