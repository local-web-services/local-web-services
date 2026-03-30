"""Given: the instance does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the instance does not exist")
def neptune_instance_does_not_exist():
    """No-op: fresh state has no instances."""
