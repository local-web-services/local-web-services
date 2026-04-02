"""Given: the "eventbridge" "bus" was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSnsTestClient
from ..constants import TEST_BUS


@given('the "eventbridge" "bus" was not "ACTIVE"')
def event_bus_is_not_active_given(lws_session, world):
    try:
        EventsSnsTestClient(lws_session)._events.delete_event_bus(Name=TEST_BUS)
    except Exception:
        pass
    lws_session.lifecycle("events").create_dwell_ms(5000).apply()
    EventsSnsTestClient(lws_session).create_bus()
    world["result"] = None
    world["error"] = None
