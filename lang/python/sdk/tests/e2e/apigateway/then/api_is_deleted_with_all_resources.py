"""
Then: the "API" is "DELETED" along with all its resources, methods, integrations, deployments,
and stages
"""

from __future__ import annotations

from pytest_bdd import then

from ..client import ApigatewayTestClient


@then(
    'the "API" is "DELETED" along with all its resources, methods, integrations, deployments, and stages'  # noqa: E501
)
def api_is_deleted_with_all_resources(lws_session, world):
    actual_result = world["result"]
    assert (
        actual_result is not None or world["error"] is None
    ), f"Expected delete_rest_api to succeed but got: {world['error']}"
    resp = ApigatewayTestClient(lws_session).get_rest_apis()
    actual_apis = resp.get("items", [])
    assert len(actual_apis) == 0, f"Expected no REST APIs after deletion but found: {actual_apis}"
