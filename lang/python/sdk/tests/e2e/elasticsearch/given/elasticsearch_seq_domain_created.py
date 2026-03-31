"""Given: an "elasticsearch" "domain" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticsearchTestClient


@given('an "elasticsearch" "domain" is created')
def elasticsearch_seq_domain_created(lws_session):
    ElasticsearchTestClient(lws_session).create_domain()
