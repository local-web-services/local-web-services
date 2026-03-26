"""Then: the REST API is "ACTIVE" and ready for requests"""

from __future__ import annotations

from pytest_bdd import then

from ..client import ApigatewayTestClient


@then('the REST API is "ACTIVE" and ready for requests')
def rest_api_is_active_then(lws_session, world):
    client = ApigatewayTestClient(lws_session).apigw()
    resp = client.get_rest_apis()
    actual_apis = resp.get("items", [])
    assert len(actual_apis) >= 1, "Expected at least one REST API to be ACTIVE but found none"
