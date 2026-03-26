"""When: a user is added to an "ACL" """

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_ACL, TEST_USER


@when('a user is added to an "ACL"')
def add_user_to_acl(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = lws_session.client("memorydb").update_acl(
            ACLName=TEST_ACL, UserNamesToAdd=[TEST_USER], UserNamesToRemove=[]
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
