"""Given: busid in bus_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiEventsTestClient


@given("busid in bus_status")
def s3api_events_busid_in_bus_status(lws_session):
    S3apiEventsTestClient(lws_session).create_bus()
