"""When: tags are added to a state machine"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_SM, TEST_TAG_KEY, TEST_TAG_VALUE, _sm_arn


@when("tags are added to a state machine")
def tag_state_machine(lws_session, world):
    try:
        sm_name = world.get("state_machine_name", TEST_SM)
        resp = lws_session.client("stepfunctions").tag_resource(
            resourceArn=_sm_arn(sm_name), tags=[{"key": TEST_TAG_KEY, "value": TEST_TAG_VALUE}]
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
