"""Given: a domain configuration update has begun"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_DOMAIN


@given("a domain configuration update has begun")
def elasticsearch_domain_config_update_begun(lws_session):
    lws_session.inject_state("es", "domain", TEST_DOMAIN, "processing")
