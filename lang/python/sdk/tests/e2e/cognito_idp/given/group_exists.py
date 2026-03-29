"""Given: the group exists"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import given

from ..client import CognitoIdpTestClient
from ..constants import TEST_GROUP_NAME, _skip_if_not_implemented


@given("the group exists")
def group_exists(lws_session, world):
    """Create a group to represent the existing state."""
    if not world.get("pool_id"):
        world["pool_id"] = CognitoIdpTestClient(lws_session).create_pool()
    try:
        CognitoIdpTestClient(lws_session).create_group(
            GroupName=TEST_GROUP_NAME, UserPoolId=world["pool_id"]
        )
    except ClientError as exc:
        _skip_if_not_implemented(exc)
        raise
    world["group_name"] = TEST_GROUP_NAME
