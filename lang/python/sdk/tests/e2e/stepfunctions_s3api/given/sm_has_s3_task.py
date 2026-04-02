"""Given: the "step functions" "state machine" has an "s3" task configured"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsS3apiTestClient
from ..constants import (
    ROLE_ARN,
    TEST_BODY,
    TEST_BUCKET,
    TEST_KEY,
    TEST_SM,
    _s3_put_object_definition,
    _sm_arn,
)


@given('the "step functions" "state machine" has an "s3" task configured')
def sm_has_s3_task(lws_session):
    """Create a state machine with an S3 putObject task; update if it already exists."""
    try:
        StepfunctionsS3apiTestClient(lws_session).create_bucket()
    except Exception:
        pass
    try:
        StepfunctionsS3apiTestClient(lws_session)._sfn.create_state_machine(
            name=TEST_SM,
            definition=_s3_put_object_definition(TEST_BUCKET, TEST_KEY, TEST_BODY.decode()),
            roleArn=ROLE_ARN,
        )
    except Exception:
        StepfunctionsS3apiTestClient(lws_session)._sfn.update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_s3_put_object_definition(TEST_BUCKET, TEST_KEY, TEST_BODY.decode()),
        )
