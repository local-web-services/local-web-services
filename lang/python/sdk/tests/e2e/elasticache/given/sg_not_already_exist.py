"""Given: the "elasticache" subnet group did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" subnet group did not already exist')
def sg_not_already_exist():
    """No-op: fresh state has no subnet groups."""
