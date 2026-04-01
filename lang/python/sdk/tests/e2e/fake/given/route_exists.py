"""Given: the route existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import FakeTestClient


@given("the route existed")
def route_exists(lws_session):
    FakeTestClient(lws_session).create_server()
    FakeTestClient(lws_session).add_route()
