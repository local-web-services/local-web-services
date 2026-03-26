"""Given: the domain already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsElasticsearchTestClient


@given("the domain already exists")
def domain_already_exists(lws_session):
    StepfunctionsElasticsearchTestClient(lws_session).create_domain()
