"""Given: the "api gateway" "resource" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "resource" was "ACTIVE"')
def resource_is_active_given():
    """No-op: resources are ACTIVE immediately after creation."""
