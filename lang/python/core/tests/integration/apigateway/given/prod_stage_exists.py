"""Given: the "api gateway" "prod stage" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ApigatewayTestClient
from ..constants import INT_API_NAME_PROD, INT_STAGE_PROD


@given('the "api gateway" "prod stage" existed')
def prod_stage_exists(client: TestClient):
    ApigatewayTestClient(client).setup_api_with_stage(INT_STAGE_PROD, INT_API_NAME_PROD)
