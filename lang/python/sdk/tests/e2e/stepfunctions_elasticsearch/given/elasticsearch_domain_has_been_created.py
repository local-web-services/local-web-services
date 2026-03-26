"""Given: an Elasticsearch domain has been created and is "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsElasticsearchTestClient


@given('an Elasticsearch domain has been created and is "AVAILABLE"')
def elasticsearch_domain_has_been_created(lws_session):
    StepfunctionsElasticsearchTestClient(lws_session).create_domain()
