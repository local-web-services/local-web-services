"""Given: a route is removed from a fake server"""

from __future__ import annotations

from pytest_bdd import given

from ..client import FakeTestClient


@given("a route is removed from a fake server")
def fake_route_has_been_removed(lws_session):
    FakeTestClient(lws_session).create_server()
    FakeTestClient(lws_session).add_route()
    FakeTestClient(lws_session).remove_route()
