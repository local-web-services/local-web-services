"""When: a REST API finishes creating and becomes active"""

from __future__ import annotations

from pytest_bdd import when


@when("a REST API finishes creating and becomes active")
def activate_rest_api(lws_session, world):
    """Disable lifecycle dwell so the REST API transitions to ACTIVE immediately."""
    import time

    lws_session.lifecycle("apigateway").create_dwell_ms(0).apply()
    time.sleep(0.2)  # brief wait for async transition to complete
