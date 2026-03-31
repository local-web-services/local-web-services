"""Given: the "api gateway" "prod stage" already existed for this "API" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayTestClient


@given('the "api gateway" "prod stage" already existed for this "API"')
def prod_stage_already_exists(lws_session, world):
    """Set up the prod stage and mark it as pre-existing in world state."""
    ApigatewayTestClient(lws_session).setup_prod_stage()
    world["_prod_stage_pre_exists"] = True
