"""Given: the target bus is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiEventsTestClient


@given('the target bus is "ACTIVE"')
def target_bus_is_active(lws_session):
    S3apiEventsTestClient(lws_session).create_bus()
