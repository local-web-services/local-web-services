"""Given: the bus is already "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiEventsTestClient
from ..constants import TEST_BUS


@given('the bus is already "DELETED"')
def bus_is_already_deleted(lws_session, world):
    try:
        S3apiEventsTestClient(lws_session).create_bus()
    except Exception:
        pass
    lws_session.lifecycle("events").delete_dwell_ms(5000).apply()
    S3apiEventsTestClient(lws_session)._events.delete_event_bus(Name=TEST_BUS)
    world["result"] = None
    world["error"] = None
