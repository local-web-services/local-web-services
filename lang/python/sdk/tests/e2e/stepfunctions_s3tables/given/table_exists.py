"""Given: the table existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsS3tablesTestClient


@given("the table existed")
def table_exists(lws_session):
    StepfunctionsS3tablesTestClient(lws_session).create_table_bucket()
