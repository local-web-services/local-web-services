"""Given: the "step functions" "state machine" has no "sqs" task configured"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSqsTestClient


@given('the "step functions" "state machine" has no "sqs" task configured')
def sm_has_no_sqs_task(lws_session, world):
    """Ensure a PASS-only state machine exists with no SQS task."""
    try:
        StepfunctionsSqsTestClient(lws_session).create_sm()
    except Exception:
        pass
    world["_sm_has_no_sqs_task"] = True
