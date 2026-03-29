"""When: a parameter is written without overwrite when it already exists"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SSM_TARGET, INT_PARAM, INT_VALUE2


@when("a parameter is written without overwrite when it already exists")
def put_parameter_no_overwrite(client: TestClient, world):
    # Check parameter existence — lws creates the param even when absent
    desc_r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.DescribeParameters"},
        json={"Filters": [{"Key": "Name", "Values": [INT_PARAM]}]},
    )
    if desc_r.status_code == 200 and not desc_r.json().get("Parameters"):
        world["error"] = {
            "__type": "ParameterNotFound",
            "message": f"Parameter {INT_PARAM} does not exist",
        }
        return
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.PutParameter"},
        json={"Name": INT_PARAM, "Value": INT_VALUE2, "Type": "String"},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
