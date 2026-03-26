"""Given: the dev stage exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayTestClient


@given("the dev stage exists")
def dev_stage_exists(lws_session):
    """Set up API + method + integration + deployment + dev stage."""
    ApigatewayTestClient(lws_session).setup_dev_stage()
