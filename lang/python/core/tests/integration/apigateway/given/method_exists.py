"""Given: the "api gateway" "method" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ApigatewayTestClient


@given('the "api gateway" "method" existed')
def method_exists(client: TestClient):
    tc = ApigatewayTestClient(client)
    if tc.get_existing_api():
        return
    api_body = tc.create_rest_api()
    api_id = api_body["id"]
    root_resource_id = api_body["rootResourceId"]
    resource_body = tc.create_child_resource(api_id, root_resource_id)
    resource_id = resource_body["id"]
    tc.put_method(api_id, resource_id)
