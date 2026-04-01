"""Given: an "opensearch" "domain" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OpensearchTestClient


@given('an "opensearch" "domain" is created')
def opensearch_search_domain_created_seq(lws_session):
    OpensearchTestClient(lws_session).create_domain()
