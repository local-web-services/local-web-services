"""Given: the "documentdb" "instance" was not "MODIFYING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "documentdb" "instance" was not "MODIFYING"')
def instance_is_not_modifying_given():
    """No-op: instances are not in MODIFYING state by default."""
