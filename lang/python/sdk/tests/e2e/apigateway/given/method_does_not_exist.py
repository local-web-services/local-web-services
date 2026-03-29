"""Given: the method does not exist"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import given

from ..client import ApigatewayTestClient
from ..constants import TEST_HTTP_METHOD


@given("the method does not exist")
def method_does_not_exist(lws_session):
    """Delete the GET method on the root resource if it exists, to enforce non-existence."""
    api_id = ApigatewayTestClient(lws_session).get_api_id()
    if api_id is None:
        return
    resource_id = ApigatewayTestClient(lws_session).get_root_resource_id(api_id)
    if resource_id is None:
        return
    try:
        ApigatewayTestClient(lws_session).delete_method(
            restApiId=api_id, resourceId=resource_id, httpMethod=TEST_HTTP_METHOD
        )
    except ClientError:
        pass
