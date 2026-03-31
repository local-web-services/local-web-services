"""Given: the tag was associated with the "step functions" "state machine" """

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..constants import _SFN_TARGET, INT_SM, INT_TAG_KEY, INT_TAG_VALUE, _sm_arn


@given('the tag was associated with the "step functions" "state machine"')
def tag_associated_with_sm(client: TestClient, world):
    sm_name = world.get("state_machine_name", INT_SM)
    client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.TagResource"},
        json={
            "resourceArn": _sm_arn(sm_name),
            "tags": [{"key": INT_TAG_KEY, "value": INT_TAG_VALUE}],
        },
    )
