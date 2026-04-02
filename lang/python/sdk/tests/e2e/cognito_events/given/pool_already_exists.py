"""Given: the "eventbridge" "bus" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoEventsTestClient


@given('the "cognito" "user pool" already existed')
def pool_already_exists(lws_session):
    CognitoEventsTestClient(lws_session).create_pool()
