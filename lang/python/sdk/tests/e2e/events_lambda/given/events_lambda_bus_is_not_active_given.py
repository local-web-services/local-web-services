"""Given: the event bus is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsLambdaTestClient
from ..constants import TEST_BUS


@given('the event bus is not "ACTIVE"')
def events_lambda_bus_is_not_active_given(lws_session, world):
    try:
        EventsLambdaTestClient(lws_session)._events.delete_event_bus(Name=TEST_BUS)
    except Exception:
        pass
    lws_session.lifecycle("events").create_dwell_ms(5000).apply()
    EventsLambdaTestClient(lws_session).create_bus()
    world["result"] = None
    world["error"] = None
