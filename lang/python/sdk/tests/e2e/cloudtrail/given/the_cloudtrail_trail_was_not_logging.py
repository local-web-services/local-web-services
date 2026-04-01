"""Given: the cloudtrail trail was not "LOGGING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import CloudtrailTestClient


@given('the cloudtrail trail was not "LOGGING"')
def the_cloudtrail_trail_was_not_logging(lws_session):
    client = CloudtrailTestClient(lws_session)
    client.create_trail()
