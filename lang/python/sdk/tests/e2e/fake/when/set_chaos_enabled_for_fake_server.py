"""When: chaos was "ENABLED" or disabled for a fake server"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_SERVER_NAME


@when('chaos was "ENABLED" or disabled for a fake server')
def set_chaos_enabled_for_fake_server(lws_session, world):
    try:
        world["result"] = lws_session.client("fake").set_chaos(
            TEST_SERVER_NAME, enabled=True, error_rate=0.5
        )
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
