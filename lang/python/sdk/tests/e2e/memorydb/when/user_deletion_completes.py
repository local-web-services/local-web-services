"""When: a "memorydb" "user" deletion completes"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_USER


@when('a "memorydb" "user" deletion completes')
def user_deletion_completes(lws_session, world):
    lws_session.inject_state("memorydb", "user", TEST_USER, "deleted")
