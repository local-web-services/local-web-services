"""Given: the target bus is not "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiEventsTestClient


@given('the target bus is not "DELETED"')
def target_bus_is_not_deleted(lws_session):
    S3apiEventsTestClient(lws_session).create_bus()
