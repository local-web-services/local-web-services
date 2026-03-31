"""When: a "rds" "instance" deletion completes"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_DB


@when('a "rds" "instance" deletion completes')
def instance_deletion_completes(lws_session, world):
    try:
        lws_session.inject_state("rds", "instance", TEST_DB, "deleted")
    except RuntimeError as exc:
        world["error"] = exc
