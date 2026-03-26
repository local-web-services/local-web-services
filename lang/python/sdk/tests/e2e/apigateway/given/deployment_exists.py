"""Given: the deployment exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayTestClient


@given("the deployment exists")
def deployment_exists(lws_session):
    """Set up API + method + integration + deployment."""
    ApigatewayTestClient(lws_session).setup_deployment()
