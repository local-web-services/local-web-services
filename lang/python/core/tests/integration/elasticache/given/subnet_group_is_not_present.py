"""Given: the "elasticache" subnet group was not present"""

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" subnet group was not present')
def subnet_group_is_not_present():
    """No-op: fresh state has no subnet groups."""
