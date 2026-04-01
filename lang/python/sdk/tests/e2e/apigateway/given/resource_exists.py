"""Given: the "api gateway" "resource" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayTestClient


@given('the "api gateway" "resource" existed')
def resource_exists(lws_session):
    ApigatewayTestClient(lws_session).get_or_create_api()
