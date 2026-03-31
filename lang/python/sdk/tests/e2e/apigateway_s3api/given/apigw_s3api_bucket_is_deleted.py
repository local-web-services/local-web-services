"""Given: the "s3" "bucket" was "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "s3" "bucket" was "DELETED"')
def apigw_s3api_bucket_is_deleted():
    pytest.skip("Cannot simulate DELETED bucket state in lws")
