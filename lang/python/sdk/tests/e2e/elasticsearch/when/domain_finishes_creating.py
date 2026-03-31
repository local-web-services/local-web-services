"""When: an "elasticsearch" "domain" finishes creating"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_DOMAIN


@when('an "elasticsearch" "domain" finishes creating')
def domain_finishes_creating(lws_session, world):
    lws_session.inject_state("es", "domain", TEST_DOMAIN, "active")
