"""Given: the prod stage exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayTestClient


@given("the prod stage exists")
def prod_stage_exists(lws_session):
    """Set up API + method + integration + deployment + prod stage."""
    ApigatewayTestClient(lws_session).setup_prod_stage()
