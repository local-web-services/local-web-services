"""Given: the object is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the object is "ACTIVE"')
def object_is_active_given():
    """No-op: objects are active once put."""
