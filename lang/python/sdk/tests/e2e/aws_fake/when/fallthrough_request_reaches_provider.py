"""When: a request for an operation not covered by the "AWS" fake reaches the provider"""

from __future__ import annotations

from pytest_bdd import when


@when('a request for an operation not covered by the "AWS" fake reaches the provider')
def fallthrough_request_reaches_provider(lws_session, world):
    try:
        world["result"] = lws_session.client("dynamodb").list_tables()
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
