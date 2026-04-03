"""When: a "rds" "instance" finishes creating"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_DB


@when('a "rds" "instance" finishes creating')
def instance_finishes_creating(lws_session, world):
    try:
        lws_session.inject_state_unchecked("rds", "instance", TEST_DB, "available")
    except RuntimeError as exc:
        world["error"] = exc
