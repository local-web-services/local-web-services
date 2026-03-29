"""Given: the bucket is "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the bucket is "ACTIVE"')
def apigw_s3api_bucket_is_active_given():
    pytest.skip("Cannot simulate bucket status states in lws")
