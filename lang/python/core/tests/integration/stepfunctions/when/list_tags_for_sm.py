"""When: tags for a "step functions" "state machine" are listed"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SFN_TARGET, INT_SM, _sm_arn


@when('tags for a "step functions" "state machine" are listed')
def list_tags_for_sm(client: TestClient, world):
    sm_name = world.get("state_machine_name", INT_SM)
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.ListTagsForResource"},
        json={"resourceArn": _sm_arn(sm_name)},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
