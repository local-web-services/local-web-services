"""Given: the "api gateway" "deployment" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "deployment" was "ACTIVE"')
@given('the "api gateway" "deployment" will be "ACTIVE"')
def deployment_is_active():
    """No-op: deployments are ACTIVE immediately after creation in lws."""
