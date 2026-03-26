"""When: an execution of the state machine is started"""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsS3apiTestClient
from ..constants import TEST_INPUT, _sm_arn


@when("an execution of the state machine is started")
def start_execution(lws_session, world):
    if world.get("_sm_has_no_s3_task"):
        pytest.skip(
            "lws does not reject start_execution when the state machine has no S3 task configured (no task definition validation)"  # noqa: E501
        )
    try:
        resp = StepfunctionsS3apiTestClient(lws_session)._sfn.start_execution(
            stateMachineArn=_sm_arn(), input=TEST_INPUT
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
