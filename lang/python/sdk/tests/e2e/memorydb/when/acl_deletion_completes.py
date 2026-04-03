"""When: an "memorydb" "ACL" deletion completes"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_ACL


@when('an "memorydb" "ACL" deletion completes')
def acl_deletion_completes(lws_session, world):
    try:
        lws_session.inject_state_unchecked(
            "memorydb",
            "acl",
            world.get("acl_id", TEST_ACL),
            "deleted",
        )
    except RuntimeError as exc:
        world["error"] = exc
