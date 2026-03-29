"""When: a running execution fails to read because no object exists in the bucket"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsS3apiTestClient
from ..constants import TEST_BUCKET, TEST_INPUT, _s3_get_object_definition, _sm_arn


@when("a running execution fails to read because no object exists in the bucket")
def execution_reads_object_not_found(lws_session, world):
    if world.get("_object_in_target_bucket"):
        world["result"] = None
        world["error"] = RuntimeError(
            "lws: cannot test 'fails to read because no object' when an object exists in the bucket"
        )
        return
    try:
        StepfunctionsS3apiTestClient(lws_session).create_bucket()
    except Exception:
        pass
    try:
        lws_session.client("stepfunctions").update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_s3_get_object_definition(TEST_BUCKET, "nonexistent-key-1"),
        )
    except Exception:
        pass
    try:
        resp = lws_session.client("stepfunctions").start_execution(
            stateMachineArn=_sm_arn(), input=TEST_INPUT
        )
        world["result"] = resp
        world["execution_arn"] = resp["executionArn"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
