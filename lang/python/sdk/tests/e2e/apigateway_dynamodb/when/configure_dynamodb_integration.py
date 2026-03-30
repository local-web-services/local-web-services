"""When: a direct DynamoDB integration is configured on the "API" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayDynamodbTestClient


@when('a direct DynamoDB integration is configured on the "API"')
def configure_dynamodb_integration(lws_session, world):
    try:
        api_id = ApigatewayDynamodbTestClient(lws_session).get_api_id()
        if api_id is None:
            world["result"] = None
            world["error"] = Exception("REST API not found")
            return
        ApigatewayDynamodbTestClient(lws_session).configure_dynamodb_integration(api_id)
        world["result"] = {"configured": True}
        world["error"] = None
        world["api_id"] = api_id
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
