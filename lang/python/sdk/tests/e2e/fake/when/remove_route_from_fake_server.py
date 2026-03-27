"""When: a route is removed from a fake server"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_ROUTE_METHOD, TEST_ROUTE_PATH, TEST_SERVER_NAME


@when("a route is removed from a fake server")
def remove_route_from_fake_server(lws_session, world):
    try:
        lws_session.client("fake").remove_route(
            TEST_SERVER_NAME, TEST_ROUTE_METHOD, TEST_ROUTE_PATH
        )
        world["result"] = {"removed": TEST_ROUTE_PATH}
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
