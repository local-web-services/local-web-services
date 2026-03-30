"""Given: the resource exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ApigatewayTestClient


@given("the resource exists")
def resource_exists(client: TestClient):
    api_body = ApigatewayTestClient(client).create_rest_api()
    api_id = api_body["id"]
    root_resource_id = api_body["rootResourceId"]
    ApigatewayTestClient(client).create_child_resource(api_id, root_resource_id)
