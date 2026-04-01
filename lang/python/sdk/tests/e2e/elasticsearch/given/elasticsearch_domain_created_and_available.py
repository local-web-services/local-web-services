"""Given: an Elasticsearch domain has been created and become "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticsearchTestClient


@given('an Elasticsearch domain has been created and become "AVAILABLE"')
def elasticsearch_domain_created_and_available(lws_session):
    ElasticsearchTestClient(lws_session).create_domain()
