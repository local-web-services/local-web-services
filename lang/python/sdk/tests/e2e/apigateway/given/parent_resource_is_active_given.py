"""Given: the parent resource is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the parent resource is "ACTIVE"')
def parent_resource_is_active_given():
    """No-op: resources are ACTIVE immediately after creation."""
