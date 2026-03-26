"""Given: a "REST" "API" has been created with a root resource"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayTestClient


@given('a "REST" "API" has been created with a root resource')
def rest_api_created_with_root_resource(lws_session):
    ApigatewayTestClient(lws_session).get_or_create_api()
