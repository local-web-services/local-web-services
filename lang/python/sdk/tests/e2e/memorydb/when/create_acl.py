"""When: an "ACL" is created"""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import MemorydbTestClient
from ..constants import TEST_ACL


@when('an "ACL" is created')
def create_acl(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = MemorydbTestClient(lws_session).create_acl(ACLName=TEST_ACL)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
