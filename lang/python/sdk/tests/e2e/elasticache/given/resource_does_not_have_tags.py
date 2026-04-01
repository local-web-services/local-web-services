"""Given: the "elasticache" "resource" does not have tags"""

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" "resource" does not have tags')
def resource_does_not_have_tags():
    """No-op: fresh resources have no tags."""
