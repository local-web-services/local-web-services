"""When: tags for a state machine are listed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsTestClient
from ..constants import TEST_SM, _sm_arn


@when("tags for a state machine are listed")
def list_tags_for_sm(lws_session, world):
    try:
        sm_name = world.get("state_machine_name", TEST_SM)
        resp = StepfunctionsTestClient(lws_session).list_tags_for_resource(
            resourceArn=_sm_arn(sm_name)
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
