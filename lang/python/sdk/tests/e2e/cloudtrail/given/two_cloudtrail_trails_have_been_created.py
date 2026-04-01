"""Given: two cloudtrail trails have been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CloudtrailTestClient


@given("two cloudtrail trails have been created")
def two_cloudtrail_trails_have_been_created(lws_session):
    CloudtrailTestClient(lws_session).create_two_trails()
