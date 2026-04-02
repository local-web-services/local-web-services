"""Given: the "step functions" "state machine" has no "s3" task configured"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsS3apiTestClient


@given('the "step functions" "state machine" has no "s3" task configured')
def sm_has_no_s3_task(lws_session, world):
    """Ensure a PASS-only state machine exists with no S3 task."""
    try:
        StepfunctionsS3apiTestClient(lws_session).create_sm()
    except Exception:
        pass
    world["_sm_has_no_s3_task"] = True
