"""Given: the domain already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaElasticsearchTestClient


@given("the domain already exists")
def domain_already_exists(lws_session):
    try:
        LambdaElasticsearchTestClient(lws_session).create_domain()
    except Exception:
        pass
