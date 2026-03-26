"""When: a REST API is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayTestClient


@when("a REST API is deleted")
def delete_rest_api(lws_session, world):
    try:
        apis = ApigatewayTestClient(lws_session).get_rest_apis()
        api_id = apis["items"][0]["id"] if apis.get("items") else None
        if api_id is None:
            world["result"] = None
            world["error"] = Exception("No REST API found to delete")
        else:
            world["result"] = ApigatewayTestClient(lws_session).delete_rest_api(restApiId=api_id)
            world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
