"""Given: the server exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import FakeTestClient


@given("the server exists")
def server_exists(lws_session):
    FakeTestClient(lws_session).create_server()
