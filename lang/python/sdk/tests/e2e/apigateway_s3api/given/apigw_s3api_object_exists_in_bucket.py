"""Given: an object "EXISTS" in the target bucket"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an object "EXISTS" in the target bucket')
def apigw_s3api_object_exists_in_bucket():
    pytest.skip("Cannot pre-seed objects for S3 integration test in lws")
