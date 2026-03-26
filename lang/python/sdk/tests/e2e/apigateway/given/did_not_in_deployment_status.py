"""Given: did not in deployment_status"""

from __future__ import annotations

from pytest_bdd import given


@given("did not in deployment_status")
def did_not_in_deployment_status():
    """No-op: fresh state has no deployments."""
