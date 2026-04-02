"""Given: the target "eventbridge" "bus" was "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiEventsTestClient
from ..constants import TEST_BUS


@given('the target "eventbridge" "bus" was "DELETED"')
def target_bus_is_deleted(lws_session):
    S3apiEventsTestClient(lws_session).create_bus()
    S3apiEventsTestClient(lws_session)._events.delete_event_bus(Name=TEST_BUS)
