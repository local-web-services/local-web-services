"""Given: the server already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import FakeTestClient


@given("the server already exists")
def server_already_exists(lws_session):
    FakeTestClient(lws_session).create_server()
