"""Given: the bucket existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsS3apiTestClient


@given("the bucket existed")
def bucket_exists(lws_session):
    StepfunctionsS3apiTestClient(lws_session).create_bucket()
