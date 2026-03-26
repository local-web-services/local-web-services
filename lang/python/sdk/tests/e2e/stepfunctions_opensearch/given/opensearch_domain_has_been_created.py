"""Given: an OpenSearch domain has been created and is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsOpensearchTestClient


@given('an OpenSearch domain has been created and is "ACTIVE"')
def opensearch_domain_has_been_created(lws_session):
    StepfunctionsOpensearchTestClient(lws_session).create_domain()
