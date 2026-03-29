"""When: parameters under a path are retrieved from "SSM" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SSM_TARGET, INT_PATH


@when('parameters under a path are retrieved from "SSM"')
def get_parameters_by_path(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.GetParametersByPath"},
        json={"Path": INT_PATH},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
