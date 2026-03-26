"""Then: the table is "ACTIVE" and its stream is ready to receive change records"""

from __future__ import annotations

from pytest_bdd import then

from ..client import DynamodbLambdaTestClient
from ..constants import TEST_TABLE


@then('the table is "ACTIVE" and its stream is ready to receive change records')
def table_is_active_stream_ready(lws_session):
    resp = DynamodbLambdaTestClient(lws_session)._dynamodb.describe_table(TableName=TEST_TABLE)
    expected_status = "ACTIVE"
    actual_status = resp["Table"].get("TableStatus", "")
    assert (
        actual_status == expected_status
    ), f"Expected table status '{expected_status}' but got '{actual_status}'"
