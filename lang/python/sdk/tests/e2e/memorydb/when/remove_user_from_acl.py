"""When: a user is removed from an "ACL" """

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import MemorydbTestClient
from ..constants import TEST_ACL, TEST_USER


@when('a user is removed from an "ACL"')
def remove_user_from_acl(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = MemorydbTestClient(lws_session).update_acl(
            ACLName=TEST_ACL, UserNamesToAdd=[], UserNamesToRemove=[TEST_USER]
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
