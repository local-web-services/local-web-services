"""Test client for stepfunctions_events tests."""

from __future__ import annotations

from .constants import PASS_DEFINITION, ROLE_ARN, TEST_BUS, TEST_INPUT, TEST_SM, _sm_arn


class StepfunctionsEventsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _sfn = lws_session.client("stepfunctions")
        self._sfn = _sfn
        _events = lws_session.client("events")
        self._events = _events

    def create_sm(self, name=TEST_SM):
        resp = self._sfn.create_state_machine(
            name=name, definition=PASS_DEFINITION, roleArn=ROLE_ARN
        )
        return resp["stateMachineArn"]

    def create_bus(self, name=TEST_BUS):
        self._events.create_event_bus(Name=name)

    def start_execution(self, name=TEST_SM):
        resp = self._sfn.start_execution(stateMachineArn=_sm_arn(name), input=TEST_INPUT)
        return resp["executionArn"]
