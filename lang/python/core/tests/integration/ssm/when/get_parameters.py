"""When: multiple parameters are retrieved from "SSM" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SSM_TARGET, INT_PARAM


@when('multiple parameters are retrieved from "SSM"')
def get_parameters(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.GetParameters"},
        json={"Names": [INT_PARAM]},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
