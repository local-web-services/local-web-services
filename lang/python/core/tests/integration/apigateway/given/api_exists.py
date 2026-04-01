"""Given: the "api gateway" "API" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ApigatewayTestClient


@given('the "api gateway" "API" existed')
def api_exists(client: TestClient):
    ApigatewayTestClient(client).create_rest_api()
