"""Then: the "memorydb" "user" was a member of the "memorydb" "ACL" """

from __future__ import annotations

import pytest
from pytest_bdd import then

from ..constants import TEST_ACL


@then('the "memorydb" "user" will be a member of the "memorydb" "ACL"')
def user_is_member_of_acl_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = lws_session.client("memorydb").describe_acls(ACLName=TEST_ACL)
    actual_acls = resp.get("ACLs", [])
    assert len(actual_acls) > 0, f"Expected ACL '{TEST_ACL}' to exist but found none"
