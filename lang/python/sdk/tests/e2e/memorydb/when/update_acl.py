"""When: an "memorydb" "ACL" is updated"""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_ACL


@when('an "memorydb" "ACL" is updated')
def update_acl(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = lws_session.client("memorydb").update_acl(
            ACLName=TEST_ACL, UserNamesToAdd=[], UserNamesToRemove=[]
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
