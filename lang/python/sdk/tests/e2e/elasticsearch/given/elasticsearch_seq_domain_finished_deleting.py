"""Given: an "elasticsearch" "domain" finishes deleting"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_DOMAIN


@given('an "elasticsearch" "domain" finishes deleting')
def elasticsearch_seq_domain_finished_deleting(lws_session):
    lws_session.inject_state("es", "domain", TEST_DOMAIN, "deleted")
