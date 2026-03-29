"""When: a running execution reads an existing object from the S3 bucket and succeeds"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsS3apiTestClient
from ..constants import (
    TEST_BODY,
    TEST_BUCKET,
    TEST_INPUT,
    TEST_KEY,
    _s3_get_object_definition,
    _sm_arn,
)


@when("a running execution reads an existing object from the S3 bucket and succeeds")
def execution_reads_object(lws_session, world):
    if world.get("_no_object_in_target_bucket"):
        world["result"] = None
        world["error"] = RuntimeError(
            "lws: cannot read an object when no object exists in the target bucket"
        )
        return
    try:
        StepfunctionsS3apiTestClient(lws_session).create_bucket()
    except Exception:
        pass
    try:
        lws_session.client("s3").put_object(Bucket=TEST_BUCKET, Key=TEST_KEY, Body=TEST_BODY)
    except Exception:
        pass
    try:
        lws_session.client("stepfunctions").update_state_machine(
            stateMachineArn=_sm_arn(), definition=_s3_get_object_definition(TEST_BUCKET, TEST_KEY)
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
