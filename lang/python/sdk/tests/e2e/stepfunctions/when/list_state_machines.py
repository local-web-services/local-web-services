"""When: all "step functions" "state machine"s are listed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when


@when('all "step functions" "state machine"s are listed')
def list_state_machines(lws_session, world):
    try:
        resp = lws_session.client("stepfunctions").list_state_machines()
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
