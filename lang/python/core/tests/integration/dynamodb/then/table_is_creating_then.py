"""Then: the "dynamodb" "table" will be in "CREATING" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import TEST_TABLE


@then('the "dynamodb" "table" will be in "CREATING" state')
def table_is_creating_then(client: TestClient):
    r = DynamodbTestClient(client).post("DescribeTable", {"TableName": TEST_TABLE})
    actual_status = r.json().get("Table", {}).get("TableStatus", "")
    expected_valid_statuses = ("CREATING", "ACTIVE")
    assert (
        actual_status in expected_valid_statuses
    ), f"Expected table to be CREATING or ACTIVE but got: {actual_status!r}"
