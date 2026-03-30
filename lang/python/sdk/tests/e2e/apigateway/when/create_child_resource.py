"""When: a child resource is created under an existing resource"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayTestClient
from ..constants import TEST_CHILD_PATH


@when("a child resource is created under an existing resource")
def create_child_resource(lws_session, world):
    try:
        api_id = ApigatewayTestClient(lws_session).get_api_id()
        if api_id is None:
            raise Exception(
                "No REST API found; cannot create child resource under a non-existent parent"
            )
        parent_id = ApigatewayTestClient(lws_session).get_root_resource_id(api_id)
        world["result"] = ApigatewayTestClient(lws_session).create_resource(
            restApiId=api_id, parentId=parent_id, pathPart=TEST_CHILD_PATH
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
