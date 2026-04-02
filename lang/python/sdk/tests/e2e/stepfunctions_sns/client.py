"""Test client for stepfunctions_sns tests."""

from __future__ import annotations

from .constants import (
    PASS_DEFINITION,
    ROLE_ARN,
    TEST_INPUT,
    TEST_SM,
    TEST_TOPIC,
    _sm_arn,
)


class StepfunctionsSnsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _sfn = lws_session.client("stepfunctions")
        self._sfn = _sfn
        _sns = lws_session.client("sns")
        self._sns = _sns

    def create_sm(self, name=TEST_SM):
        resp = self._sfn.create_state_machine(
            name=name, definition=PASS_DEFINITION, roleArn=ROLE_ARN
        )
        return resp["stateMachineArn"]

    def create_topic(self, name=TEST_TOPIC):
        self._sns.create_topic(Name=name)

    def start_execution(self, name=TEST_SM):
        resp = self._sfn.start_execution(stateMachineArn=_sm_arn(name), input=TEST_INPUT)
        return resp["executionArn"]
