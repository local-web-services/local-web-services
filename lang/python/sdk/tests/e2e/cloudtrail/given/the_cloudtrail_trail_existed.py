"""Given: the cloudtrail trail existed / the "cloudtrail" "trail" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CloudtrailTestClient


@given("the cloudtrail trail existed")
@given('the "cloudtrail" "trail" existed')
def the_cloudtrail_trail_existed(lws_session):
    CloudtrailTestClient(lws_session).create_trail()
