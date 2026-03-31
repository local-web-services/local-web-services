"""Given: the "opensearch" "domain" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaOpensearchTestClient


@given('the "opensearch" "domain" was "ACTIVE"')
def domain_is_active_given(lws_session):
    try:
        LambdaOpensearchTestClient(lws_session).create_domain()
    except Exception:
        pass
