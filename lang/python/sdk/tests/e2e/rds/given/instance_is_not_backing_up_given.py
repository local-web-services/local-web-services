"""Given: the instance is not "BACKING_UP" """

from __future__ import annotations

from pytest_bdd import given


@given('the instance is not "BACKING_UP"')
def instance_is_not_backing_up_given():
    """No-op: instances are not in BACKING_UP state by default."""
