"""Given: the "s3" "bucket" is already "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "s3" "bucket" is already "DELETED"')
def apigw_s3api_bucket_already_deleted():
    pytest.skip("Cannot simulate DELETED bucket state in lws")
