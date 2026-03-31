"""When: a "memorydb" "user" finishes creating"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_USER


@when('a "memorydb" "user" finishes creating')
def user_finishes_creating(lws_session, world):
    lws_session.inject_state("memorydb", "user", TEST_USER, "available")
