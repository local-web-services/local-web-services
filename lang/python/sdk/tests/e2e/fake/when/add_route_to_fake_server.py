"""When: a "route" is added to a "fake" "server" """

from __future__ import annotations

from pytest_bdd import when

from ..constants import (
    TEST_ROUTE_BODY,
    TEST_ROUTE_METHOD,
    TEST_ROUTE_PATH,
    TEST_ROUTE_STATUS,
    TEST_SERVER_NAME,
)


@when('a "route" is added to a "fake" "server"')
def add_route_to_fake_server(lws_session, world):
    try:
        world["result"] = lws_session.client("fake").add_route(
            TEST_SERVER_NAME,
            TEST_ROUTE_METHOD,
            TEST_ROUTE_PATH,
            status=TEST_ROUTE_STATUS,
            body=TEST_ROUTE_BODY,
        )
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
