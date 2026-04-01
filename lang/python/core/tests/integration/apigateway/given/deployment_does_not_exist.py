"""Given: the "api gateway" "deployment" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "deployment" did not exist')
def deployment_does_not_exist():
    """No-op: fresh state has no deployments."""
