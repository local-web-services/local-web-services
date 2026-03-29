"""Given: the "API" already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayTestClient


@given('the "API" already exists')
def api_already_exists(lws_session):
    ApigatewayTestClient(lws_session).get_or_create_api()
