"""Given: rid in resource_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayTestClient


@given("rid in resource_status")
def rid_in_resource_status(lws_session):
    ApigatewayTestClient(lws_session).get_or_create_api()
