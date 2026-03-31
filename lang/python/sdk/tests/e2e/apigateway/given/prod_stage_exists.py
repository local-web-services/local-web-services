"""Given: the "api gateway" "prod stage" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayTestClient


@given('the "api gateway" "prod stage" existed')
def prod_stage_exists(lws_session):
    """Set up API + method + integration + deployment + prod stage."""
    ApigatewayTestClient(lws_session).setup_prod_stage()
