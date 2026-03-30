"""Given: the parent resource exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ApigatewayTestClient


@given("the parent resource exists")
def parent_resource_exists(client: TestClient):
    ApigatewayTestClient(client).create_rest_api()
