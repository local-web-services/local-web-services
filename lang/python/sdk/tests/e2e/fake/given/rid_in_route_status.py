"""Given: rid in route_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import FakeTestClient


@given("rid in route_status")
def rid_in_route_status(lws_session):
    FakeTestClient(lws_session).create_server()
    FakeTestClient(lws_session).add_route()
