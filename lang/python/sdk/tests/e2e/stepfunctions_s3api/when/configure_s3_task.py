"""When: an "s3" task is configured on the "step functions" "state machine" """

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import (
    TEST_BODY,
    TEST_BUCKET,
    TEST_KEY,
    _s3_put_object_definition,
    _sm_arn,
)


@when('an "s3" task is configured on the "step functions" "state machine"')
def configure_s3_task(lws_session, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    try:
        world["result"] = lws_session.client("stepfunctions").update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_s3_put_object_definition(TEST_BUCKET, TEST_KEY, TEST_BODY.decode()),
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
