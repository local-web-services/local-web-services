"""Given: the "elasticache" subnet group was present"""

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" subnet group was present')
def sg_is_present():
    """No-op: subnet group is present immediately after creation."""
