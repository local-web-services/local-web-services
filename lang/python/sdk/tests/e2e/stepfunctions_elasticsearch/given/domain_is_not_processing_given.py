"""Given: the domain is not "PROCESSING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsElasticsearchTestClient


@given('the domain is not "PROCESSING"')
def domain_is_not_processing_given(lws_session):
    StepfunctionsElasticsearchTestClient(lws_session).create_domain()
