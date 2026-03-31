"""Given: the "documentdb" "instance" does not belong to this documentdb cluster"""

from __future__ import annotations

from pytest_bdd import given


@given('the "documentdb" "instance" does not belong to this documentdb cluster')
def instance_does_not_belong_to_cluster():
    """No-op: fresh state has no instances."""
