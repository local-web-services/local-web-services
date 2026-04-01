"""Given: a cloudtrail trail has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CloudtrailTestClient


@given("a cloudtrail trail has been created")
def a_cloudtrail_trail_has_been_created(lws_session):
    CloudtrailTestClient(lws_session).create_trail()
