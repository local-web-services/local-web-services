"""Given: the cloudtrail trail already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CloudtrailTestClient


@given("the cloudtrail trail already existed")
@given('the "cloudtrail" "trail" already existed')
def the_cloudtrail_trail_already_existed(lws_session):
    CloudtrailTestClient(lws_session).create_trail()
