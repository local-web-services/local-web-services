"""Given: a "route" is added to a "fake" "server" """

from __future__ import annotations

from pytest_bdd import given

from ..client import FakeTestClient


@given('a "route" is added to a "fake" "server"')
def fake_route_has_been_added(lws_session):
    FakeTestClient(lws_session).create_server()
    FakeTestClient(lws_session).add_route()
