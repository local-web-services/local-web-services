"""Test client for events_stepfunctions tests."""

from __future__ import annotations

from .constants import (
    EVENT_PATTERN,
    PASS_DEFINITION,
    ROLE_ARN,
    TEST_BUS,
    TEST_RULE,
    TEST_SM,
    _sm_arn,
)


class EventsStepfunctionsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _events = lws_session.client("events")
        self._events = _events
        _sfn = lws_session.client("stepfunctions")
        self._sfn = _sfn

    def create_bus(self, name=TEST_BUS):
        try:
            self._events.create_event_bus(Name=name)
        except Exception:
            pass

    def create_sm(self, name=TEST_SM):
        try:
            resp = self._sfn.create_state_machine(
                name=name, definition=PASS_DEFINITION, roleArn=ROLE_ARN
            )
            return resp["stateMachineArn"]
        except Exception:
            return _sm_arn()

    def create_rule_targeting_sfn(self, bus=TEST_BUS, rule=TEST_RULE):
        self.create_bus(name=bus)
        try:
            self._events.put_rule(
                Name=rule, EventBusName=bus, EventPattern=EVENT_PATTERN, State="ENABLED"
            )
        except Exception:
            pass
        try:
            self._events.put_targets(
                Rule=rule, EventBusName=bus, Targets=[{"Id": "t1", "Arn": _sm_arn()}]
            )
        except Exception:
            pass
