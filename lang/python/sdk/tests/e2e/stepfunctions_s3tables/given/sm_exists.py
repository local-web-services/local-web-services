"""Given: the "step functions" "state machine" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsS3tablesTestClient


@given('the "step functions" "state machine" existed')
def sm_exists(lws_session):
    StepfunctionsS3tablesTestClient(lws_session).create_sm()
