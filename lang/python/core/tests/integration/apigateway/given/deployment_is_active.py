"""Given: the deployment is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the deployment is "ACTIVE"')
def deployment_is_active():
    """No-op: deployments are ACTIVE immediately after creation in lws."""
