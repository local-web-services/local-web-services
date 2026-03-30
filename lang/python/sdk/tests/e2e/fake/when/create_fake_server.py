"""When: a fake server is created"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_SERVER_NAME


@when("a fake server is created")
def create_fake_server(lws_session, world):
    try:
        world["result"] = lws_session.client("fake").create_server(TEST_SERVER_NAME)
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
