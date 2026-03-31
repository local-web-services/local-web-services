"""Given: the "elasticache" parameter group did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" parameter group did not already exist')
def param_group_not_already_exist():
    """No-op: fresh state has no parameter groups."""
