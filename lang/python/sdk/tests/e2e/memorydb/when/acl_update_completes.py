"""When: an "memorydb" "ACL" update completes"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_ACL


@when('an "memorydb" "ACL" update completes')
def acl_update_completes(lws_session, world):
    try:
        lws_session.inject_state(
            "memorydb",
            "acl",
            world.get("acl_id", TEST_ACL),
            "available",
        )
    except RuntimeError as exc:
        world["error"] = exc
