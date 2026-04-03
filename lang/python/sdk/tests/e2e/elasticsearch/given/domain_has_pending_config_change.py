"""Given: the "elasticsearch" "domain" has a pending configuration change"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_DOMAIN


@given('the "elasticsearch" "domain" has a pending configuration change')
def domain_has_pending_config_change(lws_session):
    lws_session.inject_state("es", "domain", TEST_DOMAIN, "processing")
