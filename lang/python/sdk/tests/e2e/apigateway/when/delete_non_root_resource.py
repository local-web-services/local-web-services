"""When: a non-root resource is deleted along with its methods and integrations"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayTestClient


@when("a non-root resource is deleted along with its methods and integrations")
def delete_non_root_resource(lws_session, world):
    try:
        api_id = ApigatewayTestClient(lws_session).get_api_id()
        resp = ApigatewayTestClient(lws_session).get_resources(restApiId=api_id)
        non_root = [r for r in resp.get("items", []) if r.get("path") != "/"]
        if not non_root:
            world["result"] = None
            world["error"] = Exception("No non-root resource found to delete")
        else:
            world["result"] = ApigatewayTestClient(lws_session).delete_resource(
                restApiId=api_id, resourceId=non_root[0]["id"]
            )
            world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
