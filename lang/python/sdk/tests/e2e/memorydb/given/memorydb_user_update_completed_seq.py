"""Given: a user update has completed"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_USER


@given("a user update has completed")
def memorydb_user_update_completed_seq(lws_session):
    lws_session.inject_state("memorydb", "user", TEST_USER, "available")
