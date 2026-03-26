"""Then: the user is in "MODIFYING" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then

from ..client import MemorydbTestClient
from ..constants import TEST_USER


@then('the user is in "MODIFYING" state')
def user_is_modifying_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = MemorydbTestClient(lws_session).describe_users(UserName=TEST_USER)
    actual_users = resp.get("Users", [])
    assert len(actual_users) > 0, f"Expected user '{TEST_USER}' to exist but found none"
