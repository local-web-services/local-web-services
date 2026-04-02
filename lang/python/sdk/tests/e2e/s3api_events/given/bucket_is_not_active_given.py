"""Given: the "s3" "bucket" was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiEventsTestClient


@given('the "s3" "bucket" was not "ACTIVE"')
def bucket_is_not_active_given(lws_session, world):
    lws_session.lifecycle("s3").create_dwell_ms(5000).apply()
    S3apiEventsTestClient(lws_session).create_bucket()
    world["result"] = None
    world["error"] = None
