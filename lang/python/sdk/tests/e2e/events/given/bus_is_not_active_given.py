"""Given: the event bus is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient
from ..constants import TEST_BUS


@given('the event bus is not "ACTIVE"')
def bus_is_not_active_given(lws_session):
    try:
        EventsTestClient(lws_session).delete_event_bus(Name=TEST_BUS)
    except Exception:
        pass
    lws_session.lifecycle("events").create_dwell_ms(5000).apply()
    EventsTestClient(lws_session).create_bus()
