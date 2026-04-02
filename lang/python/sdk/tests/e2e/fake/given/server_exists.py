"""Given: the "fake" "server" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import FakeTestClient


@given('the "fake" "server" existed')
def server_exists(lws_session):
    FakeTestClient(lws_session).create_server()
