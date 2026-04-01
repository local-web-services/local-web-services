"""Given: the table already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsS3tablesTestClient


@given('the "step functions" "state machine" already existed')
def sm_already_exists(lws_session):
    StepfunctionsS3tablesTestClient(lws_session).create_sm()
