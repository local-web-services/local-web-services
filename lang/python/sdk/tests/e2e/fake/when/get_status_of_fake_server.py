"""When: the status of a fake server is retrieved"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_SERVER_NAME


@when("the status of a fake server is retrieved")
def get_status_of_fake_server(lws_session, world):
    try:
        world["result"] = lws_session.client("fake").get_status(TEST_SERVER_NAME)
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
