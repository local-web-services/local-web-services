"""Given: the "api gateway" "integration" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ApigatewayTestClient


@given('the "api gateway" "integration" existed')
def integration_exists(client: TestClient):
    ApigatewayTestClient(client).setup_api_with_integration()
