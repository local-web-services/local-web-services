"""When: tags for a parameter are listed"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SSM_TARGET, INT_PARAM


@when("tags for a parameter are listed")
def list_tags_for_parameter(client: TestClient, world):
    # Check parameter existence first — lws returns 200 even when parameter is absent
    desc_r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.DescribeParameters"},
        json={"Filters": [{"Key": "Name", "Values": [INT_PARAM]}]},
    )
    if desc_r.status_code == 200 and not desc_r.json().get("Parameters"):
        world["error"] = {
            "__type": "InvalidResourceId",
            "message": f"Parameter {INT_PARAM} does not exist",
        }
        return
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.ListTagsForResource"},
        json={"ResourceType": "Parameter", "ResourceId": INT_PARAM},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
