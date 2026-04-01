"""When: a "memorydb" "user" is created"""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_USER


@when('a "memorydb" "user" is created')
def create_user(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = lws_session.client("memorydb").create_user(
            UserName=TEST_USER,
            AuthenticationMode={"Type": "no-password"},
            AccessString="on ~* &* +@all",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
