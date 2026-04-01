"""Given: a "REST" "API" has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayTestClient


@given('a "REST" "API" has been deleted')
def rest_api_deleted(lws_session):
    api_id = ApigatewayTestClient(lws_session).get_api_id()
    if api_id is None:
        api = ApigatewayTestClient(lws_session).create_rest_api()
        api_id = api["id"]
    ApigatewayTestClient(lws_session).delete_rest_api(restApiId=api_id)
