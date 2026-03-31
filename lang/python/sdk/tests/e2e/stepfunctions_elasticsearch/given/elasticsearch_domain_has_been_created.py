"""Given: an "elasticsearch" "domain" is created and becomes "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsElasticsearchTestClient


@given('an "elasticsearch" "domain" is created and becomes "AVAILABLE"')
def elasticsearch_domain_has_been_created(lws_session):
    StepfunctionsElasticsearchTestClient(lws_session).create_domain()
