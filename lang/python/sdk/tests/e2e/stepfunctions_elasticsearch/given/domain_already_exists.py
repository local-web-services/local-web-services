"""Given: the "elasticsearch" "domain" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsElasticsearchTestClient


@given('the "elasticsearch" "domain" already existed')
def domain_already_exists(lws_session):
    StepfunctionsElasticsearchTestClient(lws_session).create_domain()
