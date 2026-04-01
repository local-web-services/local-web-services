"""Test client for stepfunctions tests."""

from __future__ import annotations

from botocore.exceptions import ClientError

from .constants import PASS_DEFINITION, ROLE_ARN, TEST_INPUT, TEST_SM, _sm_arn


class StepfunctionsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("stepfunctions")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def create_sm(self, name=TEST_SM, sm_type="STANDARD"):
        try:
            resp = self._client.create_state_machine(
                name=name, definition=PASS_DEFINITION, roleArn=ROLE_ARN, type=sm_type
            )
            return resp["stateMachineArn"]
        except ClientError as exc:
            if exc.response["Error"]["Code"] == "StateMachineAlreadyExists":
                return _sm_arn(name)
            raise

    def start_execution(self, sm_name=TEST_SM):
        sm_arn = _sm_arn(sm_name)
        resp = self._client.start_execution(stateMachineArn=sm_arn, input=TEST_INPUT)
        return resp["executionArn"]
