"""When: an "elasticsearch" "domain" finishes processing its configuration update"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_DOMAIN


@when('an "elasticsearch" "domain" finishes processing its configuration update')
def domain_finishes_processing(lws_session, world):
    try:
        lws_session.inject_state_unchecked(
            "es",
            "domain",
            world.get("domain_id", TEST_DOMAIN),
            "active",
        )
    except RuntimeError as exc:
        world["error"] = exc
