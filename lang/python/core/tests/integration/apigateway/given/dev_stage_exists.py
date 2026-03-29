"""Given: the dev stage exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ApigatewayTestClient
from ..constants import INT_API_NAME_DEV, INT_STAGE_DEV


@given("the dev stage exists")
def dev_stage_exists(client: TestClient):
    ApigatewayTestClient(client).setup_api_with_stage(INT_STAGE_DEV, INT_API_NAME_DEV)
