"""Given: the domain is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaOpensearchTestClient


@given('the domain is "ACTIVE"')
def domain_is_active_given(lws_session):
    try:
        LambdaOpensearchTestClient(lws_session).create_domain()
    except Exception:
        pass
