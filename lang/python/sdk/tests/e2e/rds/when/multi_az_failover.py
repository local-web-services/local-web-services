"""When: a multi-"AZ" failover is triggered on a "rds" "instance" """

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_DB


@when('a multi-"AZ" failover is triggered on a "rds" "instance"')
def multi_az_failover(lws_session, world):
    try:
        lws_session.inject_state(
            "rds",
            "instance",
            world.get("instance_id", TEST_DB),
            "available",
        )
    except RuntimeError as exc:
        world["error"] = exc
