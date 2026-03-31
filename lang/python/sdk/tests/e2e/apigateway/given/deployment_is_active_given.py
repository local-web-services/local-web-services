"""Given: the "api gateway" "deployment" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "deployment" was "ACTIVE"')
def deployment_is_active_given():
    """No-op: deployments are ACTIVE immediately after creation."""
