"""Given: the route is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import FakeTestClient


@given('the route is not "ACTIVE"')
def route_is_not_active(lws_session):
    FakeTestClient(lws_session).remove_route()
