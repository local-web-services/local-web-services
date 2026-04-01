"""Given: the "api gateway" "API" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayTestClient


@given('the "api gateway" "API" already existed')
def api_already_exists(lws_session):
    ApigatewayTestClient(lws_session).get_or_create_api()
