"""Given: the "API" exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ApigatewayTestClient


@given('the "API" exists')
def api_exists(client: TestClient):
    ApigatewayTestClient(client).create_rest_api()
