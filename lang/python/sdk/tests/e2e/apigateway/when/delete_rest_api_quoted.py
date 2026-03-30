"""When: a "REST" "API" is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayTestClient


@when('a "REST" "API" is deleted')
def delete_rest_api_quoted(lws_session, world):
    try:
        api_id = ApigatewayTestClient(lws_session).get_api_id()
        if api_id is None:
            world["result"] = None
            world["error"] = Exception("No REST API found to delete")
        else:
            world["result"] = ApigatewayTestClient(lws_session).delete_rest_api(restApiId=api_id)
            world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
