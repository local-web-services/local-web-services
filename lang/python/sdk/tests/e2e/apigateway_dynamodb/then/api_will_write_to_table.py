"""Then: the "api gateway" "api" will write to the "dynamodb" "table" when requests are received"""

from __future__ import annotations

from pytest_bdd import then

from ..client import ApigatewayDynamodbTestClient
from ..constants import _ITEM_KEY, TEST_TABLE


@then('the "api gateway" "api" will write to the "dynamodb" "table" when requests are received')
def api_will_write_to_table(lws_session, world):
    api_id = world.get("api_id") or ApigatewayDynamodbTestClient(lws_session).get_api_id()
    assert api_id is not None, "Expected API to exist"
    resp = ApigatewayDynamodbTestClient(lws_session).invoke_api(
        api_id,
        {
            "TableName": TEST_TABLE,
            "Item": {_ITEM_KEY: {"S": "check-item-1"}, "value": {"S": "ok"}},
        },
    )
    expected_status = 200
    actual_status = resp["status_code"]
    assert (
        actual_status == expected_status
    ), f"Expected status {expected_status!r} but got {actual_status!r}: {resp['body']}"
