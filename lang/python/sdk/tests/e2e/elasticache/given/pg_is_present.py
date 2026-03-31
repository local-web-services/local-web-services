"""Given: the "elasticache" parameter group was present"""

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" parameter group was present')
def pg_is_present():
    """No-op: parameter group is present immediately after creation."""
