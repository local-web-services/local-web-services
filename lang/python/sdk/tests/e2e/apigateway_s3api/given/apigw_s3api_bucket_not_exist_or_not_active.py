"""Given: the bucket does not exist or is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the bucket does not exist or is not "ACTIVE"')
def apigw_s3api_bucket_not_exist_or_not_active():
    pytest.skip("Cannot simulate non-ACTIVE bucket in lws")
