"""Given: the "s3 tables" "table" was not "DELETING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsS3tablesTestClient


@given('the "s3 tables" "table" was not "DELETING"')
def table_is_not_deleting_given(lws_session):
    StepfunctionsS3tablesTestClient(lws_session).create_table_bucket()
