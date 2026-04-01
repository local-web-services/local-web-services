"""Given: an "opensearch" "domain" is created and becomes "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsOpensearchTestClient


@given('an "opensearch" "domain" is created and becomes "ACTIVE"')
def opensearch_domain_has_been_created(lws_session):
    StepfunctionsOpensearchTestClient(lws_session).create_domain()
