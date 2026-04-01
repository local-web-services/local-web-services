"""Given: an "opensearch" "domain" finishes deleting"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_DOMAIN


@given('an "opensearch" "domain" finishes deleting')
def opensearch_search_domain_finished_deleting_seq(lws_session):
    lws_session.inject_state("opensearch", "domain", TEST_DOMAIN, "deleted")
