"""Given: the user exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given("the user exists")
def user_exists(lws_session):
    MemorydbTestClient(lws_session).create_user()
