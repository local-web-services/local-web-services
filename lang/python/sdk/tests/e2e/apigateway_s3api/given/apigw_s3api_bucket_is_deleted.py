"""Given: the bucket is "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the bucket is "DELETED"')
def apigw_s3api_bucket_is_deleted():
    pytest.skip("Cannot simulate DELETED bucket state in lws")
