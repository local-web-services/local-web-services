"""Given: an "ENABLED" rule existed on the bus targeting a function"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsLambdaTestClient


@given('an "ENABLED" rule existed on the bus targeting a function')
def events_lambda_enabled_rule_exists(lws_session):
    try:
        EventsLambdaTestClient(lws_session).create_bus()
    except Exception:
        pass
    try:
        EventsLambdaTestClient(lws_session).create_function()
    except Exception:
        pass
    EventsLambdaTestClient(lws_session).create_rule_with_target()
