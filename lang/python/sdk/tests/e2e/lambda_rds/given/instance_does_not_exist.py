"""Given: the "rds" "instance" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "rds" "instance" did not exist')
def instance_does_not_exist():
    """No-op: fresh state has no instances."""
