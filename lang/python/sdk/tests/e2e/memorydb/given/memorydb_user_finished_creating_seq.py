"""Given: a "memorydb" "user" finishes creating"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_USER


@given('a "memorydb" "user" finishes creating')
def memorydb_user_finished_creating_seq(lws_session):
    lws_session.inject_state("memorydb", "user", TEST_USER, "available")
