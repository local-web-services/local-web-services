"""Given: smid in sm_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsS3tablesTestClient


@given("smid in sm_status")
def smid_in_sm_status(lws_session):
    StepfunctionsS3tablesTestClient(lws_session).create_sm()
