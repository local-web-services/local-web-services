"""Given: the instance does not belong to this cluster"""

from __future__ import annotations

from pytest_bdd import given


@given("the instance does not belong to this cluster")
def instance_does_not_belong_to_cluster():
    """No-op: fresh state has no instances."""
