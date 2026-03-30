"""Given: aid in api_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayTestClient


@given("aid in api_status")
def aid_in_api_status(lws_session):
    ApigatewayTestClient(lws_session).get_or_create_api()
