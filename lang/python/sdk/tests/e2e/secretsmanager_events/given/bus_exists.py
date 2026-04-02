"""Given: the "eventbridge" "bus" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerEventsTestClient


@given('the "eventbridge" "bus" existed')
def bus_exists(lws_session):
    SecretsmanagerEventsTestClient(lws_session).create_bus()
