"""When: a running execution writes an object to the S3 bucket and succeeds"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsS3apiTestClient
from ..constants import (
    TEST_BODY,
    TEST_BUCKET,
    TEST_INPUT,
    TEST_KEY,
    _s3_put_object_definition,
    _sm_arn,
)


@when("a running execution writes an object to the S3 bucket and succeeds")
def execution_writes_object(lws_session, world):
    try:
        StepfunctionsS3apiTestClient(lws_session).create_bucket()
    except Exception:
        pass
    try:
        StepfunctionsS3apiTestClient(lws_session)._sfn.update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_s3_put_object_definition(TEST_BUCKET, TEST_KEY, TEST_BODY.decode()),
        )
    except Exception:
        pass
    try:
        resp = StepfunctionsS3apiTestClient(lws_session)._sfn.start_execution(
            stateMachineArn=_sm_arn(), input=TEST_INPUT
        )
        world["result"] = resp
        world["execution_arn"] = resp["executionArn"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
