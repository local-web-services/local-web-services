"""Given: a fake server has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import FakeTestClient


@given("a fake server has been created")
def fake_server_has_been_created(lws_session):
    FakeTestClient(lws_session).create_server()
