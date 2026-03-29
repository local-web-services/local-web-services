"""Given: no object "EXISTS" in the target bucket"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no object "EXISTS" in the target bucket')
def apigw_s3api_no_object_in_bucket():
    pytest.skip("Cannot verify absence of objects for S3 integration in lws")
