"""Given: the "api gateway" "API" did not exist"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayTestClient


@given('the "api gateway" "API" did not exist')
def api_does_not_exist(lws_session):
    existing_id = ApigatewayTestClient(lws_session).get_api_id()
    if existing_id is not None:
        ApigatewayTestClient(lws_session).delete_rest_api(restApiId=existing_id)
