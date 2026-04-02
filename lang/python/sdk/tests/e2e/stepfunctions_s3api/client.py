"""Test client for stepfunctions_s3api tests."""

from __future__ import annotations

from .constants import (
    PASS_DEFINITION,
    ROLE_ARN,
    TEST_BUCKET,
    TEST_INPUT,
    TEST_SM,
    _sm_arn,
)


class StepfunctionsS3apiTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _sfn = lws_session.client("stepfunctions")
        self._sfn = _sfn
        _s3 = lws_session.client("s3")
        self._s3 = _s3

    def create_sm(self, name=TEST_SM):
        resp = self._sfn.create_state_machine(
            name=name, definition=PASS_DEFINITION, roleArn=ROLE_ARN
        )
        return resp["stateMachineArn"]

    def create_bucket(self, name=TEST_BUCKET):
        self._s3.create_bucket(Bucket=name)

    def start_execution(self, name=TEST_SM):
        resp = self._sfn.start_execution(stateMachineArn=_sm_arn(name), input=TEST_INPUT)
        return resp["executionArn"]
