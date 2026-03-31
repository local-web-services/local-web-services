"""Given: the "api gateway" "API" was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayTestClient


@given('the "api gateway" "API" was not "ACTIVE"')
def api_is_not_active_given(lws_session):
    """Delete any existing API, then create a new one with lifecycle dwell in CREATING state."""
    existing_id = ApigatewayTestClient(lws_session).get_api_id()
    if existing_id is not None:
        ApigatewayTestClient(lws_session).delete_rest_api(restApiId=existing_id)
    lws_session.lifecycle("apigateway").create_dwell_ms(5000).apply()
    ApigatewayTestClient(lws_session).create_rest_api()
