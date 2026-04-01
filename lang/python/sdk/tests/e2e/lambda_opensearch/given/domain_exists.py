"""Given: the "opensearch" "domain" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaOpensearchTestClient


@given('the "opensearch" "domain" existed')
def domain_exists(lws_session):
    LambdaOpensearchTestClient(lws_session).create_domain()
