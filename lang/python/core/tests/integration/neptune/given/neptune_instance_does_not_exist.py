"""Given: the "documentdb" "instance" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "neptune" "instance" did not exist')
@given('the "documentdb" "instance" did not exist')
def neptune_instance_does_not_exist():
    """No-op: fresh state has no instances."""
