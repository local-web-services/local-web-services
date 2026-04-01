"""Given: the "elasticache" subnet group did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" subnet group did not exist')
def sg_does_not_exist():
    """No-op: fresh state has no subnet groups."""
