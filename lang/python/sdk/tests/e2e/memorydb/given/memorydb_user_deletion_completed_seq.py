"""Given: a "memorydb" "user" deletion completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_USER


@given('a "memorydb" "user" deletion completes')
def memorydb_user_deletion_completed_seq(lws_session):
    lws_session.inject_state("memorydb", "user", TEST_USER, "deleted")
