"""Given: chaos was "ENABLED" or disabled for a fake server"""

from __future__ import annotations

from pytest_bdd import given

from ..client import FakeTestClient


@given('chaos was "ENABLED" or disabled for a fake server')
def fake_chaos_has_been_enabled_or_disabled(lws_session):
    FakeTestClient(lws_session).create_server()
    FakeTestClient(lws_session).set_chaos(enabled=True)
