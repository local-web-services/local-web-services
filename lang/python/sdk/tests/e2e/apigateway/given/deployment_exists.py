"""Given: the "api gateway" "deployment" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayTestClient


@given('the "api gateway" "deployment" existed')
def deployment_exists(lws_session):
    """Set up API + method + integration + deployment."""
    ApigatewayTestClient(lws_session).setup_deployment()
