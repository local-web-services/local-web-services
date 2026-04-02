"""Given: a "fake" "server" is deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import FakeTestClient


@given('a "fake" "server" is deleted')
def fake_server_has_been_deleted(lws_session):
    FakeTestClient(lws_session).create_server()
    FakeTestClient(lws_session).delete_server()
