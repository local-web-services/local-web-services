"""Given: the bucket is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the bucket is not "ACTIVE"')
def apigw_s3api_bucket_is_not_active_given():
    pytest.skip("Cannot simulate non-ACTIVE bucket in lws")
