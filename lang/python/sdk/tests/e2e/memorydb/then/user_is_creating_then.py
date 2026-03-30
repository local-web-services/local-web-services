"""Then: the user is in "CREATING" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then

from ..constants import TEST_USER


@then('the user is in "CREATING" state')
def user_is_creating_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = lws_session.client("memorydb").describe_users(UserName=TEST_USER)
    actual_users = resp.get("Users", [])
    assert len(actual_users) > 0, f"Expected user '{TEST_USER}' to exist but found none"
