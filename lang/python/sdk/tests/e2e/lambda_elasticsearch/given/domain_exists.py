"""Given: the "elasticsearch" "domain" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaElasticsearchTestClient


@given('the "elasticsearch" "domain" existed')
def domain_exists(lws_session):
    LambdaElasticsearchTestClient(lws_session).create_domain()
