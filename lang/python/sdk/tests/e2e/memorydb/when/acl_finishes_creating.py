"""When: an "memorydb" "ACL" finishes creating"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_ACL


@when('an "memorydb" "ACL" finishes creating')
def acl_finishes_creating(lws_session, world):
    try:
        lws_session.inject_state_unchecked(
            "memorydb",
            "acl",
            world.get("acl_id", TEST_ACL),
            "available",
        )
    except RuntimeError as exc:
        world["error"] = exc
