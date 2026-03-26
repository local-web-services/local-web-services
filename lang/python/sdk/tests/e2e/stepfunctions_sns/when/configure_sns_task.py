"""When: an "SNS" publish task is configured on the state machine"""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsSnsTestClient
from ..constants import TEST_TOPIC, _sm_arn, _sns_task_definition


@when('an "SNS" publish task is configured on the state machine')
def configure_sns_task(lws_session, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    try:
        world["result"] = StepfunctionsSnsTestClient(lws_session)._sfn.update_state_machine(
            stateMachineArn=_sm_arn(), definition=_sns_task_definition(TEST_TOPIC)
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
