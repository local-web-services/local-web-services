"""
Given: an EventBridge rule has been created to asynchronously invoke a Lambda function on
matching events
"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsLambdaTestClient


@given(
    "an EventBridge rule has been created to asynchronously invoke a Lambda function on matching events"  # noqa: E501
)
def events_lambda_seq_rule_created(lws_session):
    try:
        EventsLambdaTestClient(lws_session).create_bus()
    except Exception:
        pass
    try:
        EventsLambdaTestClient(lws_session).create_function()
    except Exception:
        pass
    EventsLambdaTestClient(lws_session).create_rule_with_target()
