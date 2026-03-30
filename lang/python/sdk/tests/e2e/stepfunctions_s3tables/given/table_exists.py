"""Given: the table exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsS3tablesTestClient


@given("the table exists")
def table_exists(lws_session):
    StepfunctionsS3tablesTestClient(lws_session).create_table_bucket()
