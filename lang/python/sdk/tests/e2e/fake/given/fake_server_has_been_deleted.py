"""Given: a fake server has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import FakeTestClient


@given("a fake server has been deleted")
def fake_server_has_been_deleted(lws_session):
    FakeTestClient(lws_session).create_server()
    FakeTestClient(lws_session).delete_server()
