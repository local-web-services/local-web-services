"""Given: the tag is associated with the state machine"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsTestClient
from ..constants import TEST_SM, TEST_TAG_KEY, TEST_TAG_VALUE, _sm_arn


@given("the tag is associated with the state machine")
def tag_associated_with_sm(lws_session, world):
    sm_name = world.get("state_machine_name", TEST_SM)
    StepfunctionsTestClient(lws_session).tag_resource(
        resourceArn=_sm_arn(sm_name), tags=[{"key": TEST_TAG_KEY, "value": TEST_TAG_VALUE}]
    )
