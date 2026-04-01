"""Given: pid in pool_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoEventsTestClient


@given("pid in pool_status")
def cognito_events_pid_in_pool_status(lws_session):
    CognitoEventsTestClient(lws_session).create_pool()
