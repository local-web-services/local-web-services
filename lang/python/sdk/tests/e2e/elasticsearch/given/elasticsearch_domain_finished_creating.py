"""Given: an "elasticsearch" "domain" finishes creating"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticsearchTestClient


@given('an "elasticsearch" "domain" finishes creating')
def elasticsearch_domain_finished_creating(lws_session):
    ElasticsearchTestClient(lws_session).create_domain()
