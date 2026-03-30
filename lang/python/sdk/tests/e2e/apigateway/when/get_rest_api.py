"""When: a REST API is retrieved"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when


@when("a REST API is retrieved")
def get_rest_api(lws_session, world):
    try:
        apis = lws_session.client("apigateway").get_rest_apis()
        api_id = apis["items"][0]["id"] if apis.get("items") else None
        if api_id is None:
            world["result"] = None
            world["error"] = Exception("No REST API found to retrieve")
        else:
            world["result"] = lws_session.client("apigateway").get_rest_api(restApiId=api_id)
            world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
