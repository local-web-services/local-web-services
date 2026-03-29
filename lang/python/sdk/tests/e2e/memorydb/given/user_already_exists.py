"""Given: the user already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given("the user already exists")
def user_already_exists(lws_session):
    MemorydbTestClient(lws_session).create_user()
