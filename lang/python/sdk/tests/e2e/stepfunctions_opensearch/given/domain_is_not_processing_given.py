"""Given: the "opensearch" "domain" was not "PROCESSING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsOpensearchTestClient


@given('the "opensearch" "domain" was not "PROCESSING"')
def domain_is_not_processing_given(lws_session):
    StepfunctionsOpensearchTestClient(lws_session).create_domain()
