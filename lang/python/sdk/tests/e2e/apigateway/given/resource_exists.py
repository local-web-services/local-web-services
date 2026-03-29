"""Given: the resource exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayTestClient


@given("the resource exists")
def resource_exists(lws_session):
    ApigatewayTestClient(lws_session).get_or_create_api()
