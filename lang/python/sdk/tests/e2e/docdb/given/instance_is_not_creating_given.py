"""Given: the instance is not "CREATING" """

from __future__ import annotations

from pytest_bdd import given


@given('the instance is not "CREATING"')
def instance_is_not_creating_given():
    """No-op: instances are not in CREATING state by default."""
