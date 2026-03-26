"""Then: the table is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..client import LambdaDynamodbTestClient
from ..constants import TEST_TABLE


@then('the table is "ACTIVE"')
def table_is_active_then(lws_session):
    resp = LambdaDynamodbTestClient(lws_session)._dynamo.describe_table(TableName=TEST_TABLE)
    expected_status = "ACTIVE"
    actual_status = resp["Table"]["TableStatus"]
    assert (
        actual_status == expected_status
    ), f"Expected table status '{expected_status}' but got '{actual_status}'"
