"""When: an "opensearch" "domain" finishes creating"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_DOMAIN


@when('an "opensearch" "domain" finishes creating')
def domain_finishes_creating(lws_session, world):
    try:
        lws_session.inject_state("opensearch", "domain", TEST_DOMAIN, "active")
    except RuntimeError as exc:
        world["error"] = exc
