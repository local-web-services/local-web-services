"""Given: the "neptune" "instance" was not "REBOOTING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "neptune" "instance" was not "REBOOTING"')
def instance_is_not_rebooting_given():
    """No-op: instances are not in REBOOTING state by default."""
