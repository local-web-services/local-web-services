"""Given: the "eventbridge" "bus" is already "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaEventsTestClient
from ..constants import TEST_BUS


@given('the "eventbridge" "bus" is already "DELETED"')
def bus_is_already_deleted(lws_session, world):
    try:
        LambdaEventsTestClient(lws_session)._events.delete_event_bus(Name=TEST_BUS)
    except Exception:
        pass
    world["result"] = None
    world["error"] = None
