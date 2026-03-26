"""Given: the resource is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the resource is "ACTIVE"')
def resource_is_active_given():
    """No-op: resources are ACTIVE immediately after creation."""
