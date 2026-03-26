"""When: tags are added to a state machine"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SFN_TARGET, INT_SM, INT_TAG_KEY, INT_TAG_VALUE, _sm_arn


@when("tags are added to a state machine")
def tag_state_machine(client: TestClient, world):
    sm_name = world.get("state_machine_name", INT_SM)
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.TagResource"},
        json={
            "resourceArn": _sm_arn(sm_name),
            "tags": [{"key": INT_TAG_KEY, "value": INT_TAG_VALUE}],
        },
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
