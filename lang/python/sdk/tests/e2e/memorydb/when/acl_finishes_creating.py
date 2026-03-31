"""When: an "memorydb" "ACL" finishes creating"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_ACL


@when('an "memorydb" "ACL" finishes creating')
def acl_finishes_creating(lws_session, world):
    lws_session.inject_state("memorydb", "acl", TEST_ACL, "available")
