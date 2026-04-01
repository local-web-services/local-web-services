"""Given: tid in table_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsS3tablesTestClient


@given("tid in table_status")
def tid_in_table_status(lws_session):
    StepfunctionsS3tablesTestClient(lws_session).create_table_bucket()
