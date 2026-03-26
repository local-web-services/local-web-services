"""When: tags are removed from a state machine"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsTestClient
from ..constants import TEST_SM, TEST_TAG_KEY, _sm_arn


@when("tags are removed from a state machine")
def untag_state_machine(lws_session, world):
    try:
        sm_name = world.get("state_machine_name", TEST_SM)
        resp = StepfunctionsTestClient(lws_session).untag_resource(
            resourceArn=_sm_arn(sm_name), tagKeys=[TEST_TAG_KEY]
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
