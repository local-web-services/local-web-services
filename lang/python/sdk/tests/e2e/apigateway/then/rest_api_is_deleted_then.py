"""Then: the REST API is deleted"""

from __future__ import annotations

from pytest_bdd import then

from ..client import ApigatewayTestClient


@then("the REST API is deleted")
def rest_api_is_deleted_then(lws_session):
    client = ApigatewayTestClient(lws_session).apigw()
    resp = client.get_rest_apis()
    actual_apis = resp.get("items", [])
    assert len(actual_apis) == 0, f"Expected no REST APIs after deletion but found: {actual_apis}"
