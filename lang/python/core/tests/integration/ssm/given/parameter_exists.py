"""Given: the "ssm" "parameter" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import SsmTestClient


@given('the "ssm" "parameter" existed')
def parameter_exists(client: TestClient):
    SsmTestClient(client).put_parameter()
