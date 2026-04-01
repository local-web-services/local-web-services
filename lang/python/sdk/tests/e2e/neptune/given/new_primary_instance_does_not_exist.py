"""Given: the new primary "neptune" "instance" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the new primary "neptune" "instance" did not exist')
def new_primary_instance_does_not_exist():
    """No-op: fresh state has no instances."""
