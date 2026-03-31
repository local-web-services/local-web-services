"""Given: the "neptune" "instance" does not belong to this neptune cluster"""

from __future__ import annotations

from pytest_bdd import given


@given('the "neptune" "instance" does not belong to this neptune cluster')
def instance_does_not_belong_to_cluster():
    """No-op: fresh state has no instances."""
