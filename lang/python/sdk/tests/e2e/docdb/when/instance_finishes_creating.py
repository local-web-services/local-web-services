"""When: a "documentdb" "instance" finishes creating"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_INSTANCE


@when('a "documentdb" "instance" finishes creating')
def instance_finishes_creating(lws_session, world):
    try:
        lws_session.inject_state_unchecked("docdb", "instance", TEST_INSTANCE, "available")
    except RuntimeError as exc:
        world["error"] = exc
