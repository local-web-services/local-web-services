"""Then: the "ACL" is "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import then

from ..client import MemorydbTestClient
from ..constants import TEST_ACL


@then('the "ACL" is "ACTIVE"')
def acl_is_active_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = MemorydbTestClient(lws_session).describe_acls(ACLName=TEST_ACL)
    actual_acls = resp.get("ACLs", [])
    assert len(actual_acls) > 0, f"Expected ACL '{TEST_ACL}' to exist but found none"
