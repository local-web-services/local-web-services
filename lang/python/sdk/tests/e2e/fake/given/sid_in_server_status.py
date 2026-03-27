"""Given: sid in server_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import FakeTestClient


@given("sid in server_status")
def sid_in_server_status(lws_session):
    FakeTestClient(lws_session).create_server()
