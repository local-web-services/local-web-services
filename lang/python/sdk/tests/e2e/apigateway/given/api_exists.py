"""Given: the "api gateway" "API" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayTestClient


@given('the "api gateway" "API" existed')
def api_exists(lws_session):
    ApigatewayTestClient(lws_session).get_or_create_api()
