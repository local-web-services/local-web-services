"""When: a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayDynamodbTestClient
from ..constants import _ITEM_KEY, TEST_TABLE


@when(
    'a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200'
)
def request_writes_to_dynamodb(lws_session, world):
    try:
        api_id = world.get("api_id") or ApigatewayDynamodbTestClient(lws_session).get_api_id()
        resp = ApigatewayDynamodbTestClient(lws_session).invoke_api(
            api_id,
            {
                "TableName": TEST_TABLE,
                "Item": {_ITEM_KEY: {"S": "e2e-item-1"}, "value": {"S": "hello"}},
            },
        )
        world["result"] = resp
        world["invoke_status"] = resp["status_code"]
        if resp["status_code"] != 200:
            world["error"] = Exception(
                f"API request failed with status {resp['status_code']}: {resp.get('body', '')}"
            )
        else:
            world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
