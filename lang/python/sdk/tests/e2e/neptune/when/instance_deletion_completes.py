"""When: a "neptune" "instance" deletion completes"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_INSTANCE


@when('a "neptune" "instance" deletion completes')
def instance_deletion_completes(lws_session, world):
    try:
        lws_session.inject_state_unchecked("neptune", "instance", TEST_INSTANCE, "deleted")
    except RuntimeError as exc:
        world["error"] = exc
