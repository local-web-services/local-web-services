"""Given: the "rds" "instance" was not "DELETING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "rds" "instance" was not "DELETING"')
def instance_is_not_deleting_given():
    """No-op: instances are not in DELETING state by default."""
