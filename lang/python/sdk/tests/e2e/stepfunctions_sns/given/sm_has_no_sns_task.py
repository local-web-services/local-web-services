"""Given: the "step functions" "state machine" has no "sns" task configured"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSnsTestClient


@given('the "step functions" "state machine" has no "sns" task configured')
def sm_has_no_sns_task(lws_session, world):
    """Ensure a PASS-only state machine exists with no SNS task."""
    try:
        StepfunctionsSnsTestClient(lws_session).create_sm()
    except Exception:
        pass
    world["_sm_has_no_sns_task"] = True
