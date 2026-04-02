"""Given: the "cloudtrail" "trail" was "LOGGING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import CloudtrailTestClient


@given('the cloudtrail trail was "LOGGING"')
@given('the "cloudtrail" "trail" was "LOGGING"')
def the_cloudtrail_trail_was_logging(lws_session):
    client = CloudtrailTestClient(lws_session)
    client.create_trail()
    client.start_logging()
