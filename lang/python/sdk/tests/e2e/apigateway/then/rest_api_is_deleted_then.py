"""Then: a "api gateway" "REST API" is deleted"""

from __future__ import annotations

from pytest_bdd import then


@then('a "api gateway" "REST API" is deleted')
def rest_api_is_deleted_then(lws_session):
    client = lws_session.client("apigateway")
    resp = client.get_rest_apis()
    actual_apis = resp.get("items", [])
    assert len(actual_apis) == 0, f"Expected no REST APIs after deletion but found: {actual_apis}"
