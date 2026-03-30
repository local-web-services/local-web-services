"""Given: a user has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient
from ..constants import TEST_USER


@given("a user has been deleted")
def memorydb_user_deleted_seq(lws_session):
    try:
        MemorydbTestClient(lws_session).create_user()
    except Exception:
        pass
    MemorydbTestClient(lws_session).delete_user(UserName=TEST_USER)
