"""Given: the "api gateway" "resource" is not the root "api gateway" "resource" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import given

from ..client import ApigatewayTestClient
from ..constants import TEST_CHILD_PATH


@given('the "api gateway" "resource" is not the root "api gateway" "resource"')
def resource_is_not_root_resource(lws_session):
    """Create a child resource so there is a non-root resource to operate on."""
    api_id = ApigatewayTestClient(lws_session).get_or_create_api()
    parent_id = ApigatewayTestClient(lws_session).get_root_resource_id(api_id)
    try:
        ApigatewayTestClient(lws_session).create_resource(
            restApiId=api_id, parentId=parent_id, pathPart=TEST_CHILD_PATH
        )
    except ClientError:
        pass
