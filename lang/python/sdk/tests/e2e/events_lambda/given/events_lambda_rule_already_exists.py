"""Given: the "eventbridge" "bus" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsLambdaTestClient


@given('the "eventbridge" "rule" already existed')
def events_lambda_rule_already_exists(lws_session):
    try:
        EventsLambdaTestClient(lws_session).create_bus()
    except Exception:
        pass
    try:
        EventsLambdaTestClient(lws_session).create_function()
    except Exception:
        pass
    EventsLambdaTestClient(lws_session).create_rule_with_target()
