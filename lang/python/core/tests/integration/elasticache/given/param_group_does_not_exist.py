"""Given: the "elasticache" parameter group did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" parameter group did not exist')
def param_group_does_not_exist():
    """No-op: fresh state has no parameter groups."""
