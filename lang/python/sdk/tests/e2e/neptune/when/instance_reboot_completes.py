"""When: a "neptune" "instance" reboot completes"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_INSTANCE


@when('a "neptune" "instance" reboot completes')
def instance_reboot_completes(lws_session, world):
    try:
        lws_session.inject_state_unchecked("neptune", "instance", TEST_INSTANCE, "available")
    except RuntimeError as exc:
        world["error"] = exc
