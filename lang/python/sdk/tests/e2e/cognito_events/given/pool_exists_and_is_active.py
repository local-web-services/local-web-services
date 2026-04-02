"""Given: the "eventbridge" "bus" existed and was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoEventsTestClient


@given('the "cognito" "user pool" existed and was "ACTIVE"')
def pool_exists_and_is_active(lws_session):
    CognitoEventsTestClient(lws_session).create_pool()
