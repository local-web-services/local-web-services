"""Given: the integration exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayTestClient


@given("the integration exists")
def the_integration_exists(lws_session):
    """Set up an API with a root resource, GET method, and HTTP integration."""
    ApigatewayTestClient(lws_session).setup_integration()
