"""When: a user is updated"""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import MemorydbTestClient
from ..constants import TEST_USER


@when("a user is updated")
def update_user(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = MemorydbTestClient(lws_session).update_user(
            UserName=TEST_USER, AccessString="on ~* &* +@read"
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
