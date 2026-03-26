"""Given: the domain exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsElasticsearchTestClient


@given("the domain exists")
def domain_exists(lws_session):
    StepfunctionsElasticsearchTestClient(lws_session).create_domain()
