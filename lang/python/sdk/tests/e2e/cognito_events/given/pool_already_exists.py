"""Given: the pool already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoEventsTestClient


@given("the pool already exists")
def pool_already_exists(lws_session):
    CognitoEventsTestClient(lws_session).create_pool()
