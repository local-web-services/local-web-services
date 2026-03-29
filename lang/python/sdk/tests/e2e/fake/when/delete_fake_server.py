"""When: a fake server is deleted"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_SERVER_NAME


@when("a fake server is deleted")
def delete_fake_server(lws_session, world):
    try:
        lws_session.client("fake").delete_server(TEST_SERVER_NAME)
        world["result"] = {"deleted": TEST_SERVER_NAME}
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
