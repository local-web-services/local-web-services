"""Given: a "fake" "server" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import FakeTestClient


@given('a "fake" "server" is created')
def fake_server_has_been_created(lws_session):
    FakeTestClient(lws_session).create_server()
