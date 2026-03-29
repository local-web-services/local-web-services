"""When: multiple parameters are deleted from "SSM" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SSM_TARGET, INT_PARAM


@when('multiple parameters are deleted from "SSM"')
def delete_parameters(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.DeleteParameters"},
        json={"Names": [INT_PARAM]},
    )
    if r.status_code == 200:
        body = r.json()
        if body.get("InvalidParameters"):
            world["error"] = {
                "__type": "ParameterNotFound",
                "message": f"Parameter not found: {body['InvalidParameters']}",
            }
        else:
            world["result"] = body
    else:
        world["error"] = r.json()
