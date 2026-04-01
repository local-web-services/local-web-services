"""When: a "ssm" "parameter" is stored"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SSM_TARGET, INT_PARAM, INT_VALUE


@when('a "ssm" "parameter" is stored')
def put_parameter_create(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.PutParameter"},
        json={"Name": INT_PARAM, "Value": INT_VALUE, "Type": "String"},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
