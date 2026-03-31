"""Given: the "rds" "instance" was not "RESTORING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "rds" "instance" was not "RESTORING"')
def instance_is_not_restoring_given():
    """No-op: instances are not in RESTORING state by default."""
