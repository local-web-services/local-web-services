"""Test client for events_lambda tests."""

from __future__ import annotations

from .constants import EVENT_PATTERN, ROLE_ARN, TEST_BUS, TEST_FUNC, TEST_RULE


class EventsLambdaTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _events = lws_session.client("events")
        self._events = _events
        _lambda = lws_session.client("lambda")
        self._lambda = _lambda

    def create_bus(self, name=TEST_BUS):
        try:
            self._events.create_event_bus(Name=name)
        except Exception:
            pass

    def create_function(self, name=TEST_FUNC):
        try:
            self._lambda.create_function(
                FunctionName=name,
                Runtime="python3.12",
                Role=ROLE_ARN,
                Handler="index.handler",
                Code={"ZipFile": b"fake"},
            )
        except Exception:
            pass

    def create_rule_with_target(self):
        self.create_bus()
        try:
            self._events.put_rule(
                Name=TEST_RULE,
                EventBusName=TEST_BUS,
                EventPattern=EVENT_PATTERN,
                State="ENABLED",
            )
        except Exception:
            pass
        try:
            self._events.put_targets(
                Rule=TEST_RULE,
                EventBusName=TEST_BUS,
                Targets=[
                    {
                        "Id": "t1",
                        "Arn": f"arn:aws:lambda:us-east-1:000000000000:function:{TEST_FUNC}",
                    }
                ],
            )
        except Exception:
            pass
