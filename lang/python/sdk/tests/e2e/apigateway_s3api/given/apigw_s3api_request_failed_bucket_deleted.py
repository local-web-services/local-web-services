"""Given: a request has failed because the S3 bucket has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a request has failed because the S3 bucket has been deleted")
def apigw_s3api_request_failed_bucket_deleted():
    pytest.skip("Cannot represent a failed S3 bucket request as sequence setup in lws")
