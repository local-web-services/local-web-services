"""Test client for stepfunctions_lambda tests."""

from __future__ import annotations

from .constants import PASS_DEFINITION, ROLE_ARN, TEST_FUNC, TEST_INPUT, TEST_SM, _sm_arn


class StepfunctionsLambdaTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _sfn = lws_session.client("stepfunctions")
        self._sfn = _sfn
        _lambda = lws_session.client("lambda")
        self._lambda = _lambda

    def create_sm(self, name=TEST_SM, definition=PASS_DEFINITION):
        resp = self._sfn.create_state_machine(name=name, definition=definition, roleArn=ROLE_ARN)
        return resp["stateMachineArn"]

    def create_function(self, name=TEST_FUNC):
        self._lambda.create_function(
            FunctionName=name,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )

    def start_execution(self, name=TEST_SM):
        resp = self._sfn.start_execution(stateMachineArn=_sm_arn(name), input=TEST_INPUT)
        return resp["executionArn"]
