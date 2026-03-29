"""Given: the deployment exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ApigatewayTestClient


@given("the deployment exists")
def deployment_exists(client: TestClient):
    api_body = ApigatewayTestClient(client).create_rest_api()
    api_id = api_body["id"]
    ApigatewayTestClient(client).create_deployment(api_id)
