"""Given: an Elasticsearch domain has been created and become "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaElasticsearchTestClient


@given('an Elasticsearch domain has been created and become "AVAILABLE"')
def lambda_elasticsearch_seq_domain_created(lws_session):
    LambdaElasticsearchTestClient(lws_session).create_domain()
