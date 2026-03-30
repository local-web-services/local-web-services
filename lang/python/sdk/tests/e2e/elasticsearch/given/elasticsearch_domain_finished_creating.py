"""Given: a search domain has finished creating"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticsearchTestClient


@given("a search domain has finished creating")
def elasticsearch_domain_finished_creating(lws_session):
    ElasticsearchTestClient(lws_session).create_domain()
