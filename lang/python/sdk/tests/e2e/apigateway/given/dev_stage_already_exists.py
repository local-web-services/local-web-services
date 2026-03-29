"""Given: the dev stage already exists for this "API" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayTestClient


@given('the dev stage already exists for this "API"')
def dev_stage_already_exists(lws_session, world):
    """Set up the dev stage and mark it as pre-existing in world state."""
    ApigatewayTestClient(lws_session).setup_dev_stage()
    world["_dev_stage_pre_exists"] = True
