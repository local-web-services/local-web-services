"""Given: the status of a "fake" "server" is retrieved"""

from __future__ import annotations

from pytest_bdd import given

from ..client import FakeTestClient


@given('the status of a "fake" "server" is retrieved')
def fake_server_status_has_been_retrieved(lws_session):
    FakeTestClient(lws_session).create_server()
    FakeTestClient(lws_session).get_status()
