"""Given: the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation')
def lambda_written_object_to_bucket_seq():
    pytest.skip("Cannot trigger Lambda S3 write in lws")
