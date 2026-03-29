"""Given: did in deployment_status"""

from __future__ import annotations

from pytest_bdd import given


@given("did in deployment_status")
def did_in_deployment_status(lws_session):
    """No-op: deployments are established during API setup in the test."""
