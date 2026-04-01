"""When: an "elasticsearch" "domain" finishes deleting"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_DOMAIN


@when('an "elasticsearch" "domain" finishes deleting')
def domain_finishes_deleting(lws_session, world):
    try:
        lws_session.inject_state("es", "domain", TEST_DOMAIN, "deleted")
    except RuntimeError as exc:
        world["error"] = exc
