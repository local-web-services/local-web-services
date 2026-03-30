"""Given: the domain is "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaElasticsearchTestClient


@given('the domain is "AVAILABLE"')
def domain_is_available_given(lws_session):
    try:
        LambdaElasticsearchTestClient(lws_session).create_domain()
    except Exception:
        pass
