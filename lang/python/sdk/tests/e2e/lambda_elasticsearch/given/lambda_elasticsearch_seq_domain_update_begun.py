"""Given: a "elasticsearch" "domain" configuration update begins"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_DOMAIN


@given('a "elasticsearch" "domain" configuration update begins')
def lambda_elasticsearch_seq_domain_update_begun(lws_session):
    lws_session.inject_state("es", "domain", TEST_DOMAIN, "processing")
