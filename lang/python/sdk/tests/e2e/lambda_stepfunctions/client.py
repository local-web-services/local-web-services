"""Test client for lambda_stepfunctions tests."""

from __future__ import annotations

from .constants import PASS_DEFINITION, ROLE_ARN, TEST_FUNC, TEST_SM


class LambdaStepfunctionsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _lambda = lws_session.client("lambda")
        self._lambda = _lambda
        _sfn = lws_session.client("stepfunctions")
        self._sfn = _sfn

    def create_function(self, name=TEST_FUNC):
        self._lambda.create_function(
            FunctionName=name,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )

    def create_sm(self, name=TEST_SM):
        resp = self._sfn.create_state_machine(
            name=name, definition=PASS_DEFINITION, roleArn=ROLE_ARN
        )
        return resp["stateMachineArn"]
