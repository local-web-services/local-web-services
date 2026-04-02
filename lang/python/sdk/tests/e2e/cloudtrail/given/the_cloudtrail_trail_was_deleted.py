"""Given: the "cloudtrail" "trail" was "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import CloudtrailTestClient


@given('the "cloudtrail" "trail" was "DELETED"')
def the_cloudtrail_trail_was_deleted(lws_session):
    client = CloudtrailTestClient(lws_session)
    client.create_trail()
    client.delete_trail()
