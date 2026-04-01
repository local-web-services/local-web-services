"""Given: a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"'
)
def apigw_s3api_put_request_written():
    pytest.skip("Cannot represent a completed API-to-S3 write as sequence setup in lws")
