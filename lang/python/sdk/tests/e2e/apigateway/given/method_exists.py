"""Given: the "api gateway" "method" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayTestClient


@given('the "api gateway" "method" existed')
def method_exists(lws_session):
    """Set up an API with a root resource and a GET method."""
    ApigatewayTestClient(lws_session).setup_method()
