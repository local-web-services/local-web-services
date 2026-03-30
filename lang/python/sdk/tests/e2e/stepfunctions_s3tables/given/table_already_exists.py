"""Given: the table already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsS3tablesTestClient


@given("the table already exists")
def table_already_exists(lws_session):
    StepfunctionsS3tablesTestClient(lws_session).create_table_bucket()
