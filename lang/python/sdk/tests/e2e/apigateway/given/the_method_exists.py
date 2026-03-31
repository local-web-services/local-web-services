"""Given: the method existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayTestClient


@given("the method existed")
def the_method_exists(lws_session):
    """Set up an API with a root resource and a GET method."""
    ApigatewayTestClient(lws_session).setup_method()
