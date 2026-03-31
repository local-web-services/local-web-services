"""Given: the "api gateway" "method" has an "api gateway" "integration" """

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ApigatewayTestClient


@given('the "api gateway" "method" has an "api gateway" "integration"')
def method_has_integration(client: TestClient):
    ApigatewayTestClient(client).setup_api_with_integration()
