"""When: all state machines are listed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsTestClient


@when("all state machines are listed")
def list_state_machines(lws_session, world):
    try:
        resp = StepfunctionsTestClient(lws_session).list_state_machines()
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
