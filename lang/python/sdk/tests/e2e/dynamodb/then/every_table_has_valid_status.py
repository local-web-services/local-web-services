"""Then: every table has a valid status ("CREATING", "ACTIVE", or "DELETED")"""

from __future__ import annotations

from pytest_bdd import then

from ..client import DynamodbTestClient


@then('every table has a valid status ("CREATING", "ACTIVE", or "DELETED")')
def every_table_has_valid_status(lws_session):
    client = DynamodbTestClient(lws_session).dynamo()
    resp = client.list_tables()
    actual_table_names = resp.get("TableNames", [])
    expected_valid_statuses = ("CREATING", "ACTIVE")
    for table_name in actual_table_names:
        table_resp = client.describe_table(TableName=table_name)
        actual_status = table_resp["Table"]["TableStatus"]
        assert (
            actual_status in expected_valid_statuses
        ), f"Expected table '{table_name}' status to be one of {expected_valid_statuses} but got: {actual_status}"  # noqa: E501
