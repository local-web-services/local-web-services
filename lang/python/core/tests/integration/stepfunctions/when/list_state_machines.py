"""When: all "step functions" "state machine"s are listed"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SFN_TARGET


@when('all "step functions" "state machine"s are listed')
def list_state_machines(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.ListStateMachines"},
        json={},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
