"""Given: the state machine had no DynamoDB task configured"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsDynamodbTestClient


@given("the state machine had no DynamoDB task configured")
def sm_has_no_dynamodb_task(lws_session, world):
    """Ensure a PASS-only state machine exists with no DynamoDB task."""
    try:
        StepfunctionsDynamodbTestClient(lws_session).create_sm()
    except Exception:
        pass
    world["_sm_has_no_dynamodb_task"] = True
