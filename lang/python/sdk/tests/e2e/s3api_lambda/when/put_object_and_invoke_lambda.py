"""
When: an object is put into the bucket and asynchronously invokes the configured Lambda function
"""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BODY, TEST_BUCKET, TEST_KEY


@when(
    'an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"'
)
def put_object_and_invoke_lambda(lws_session, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    try:
        resp = lws_session.client("s3").put_object(Bucket=TEST_BUCKET, Key=TEST_KEY, Body=TEST_BODY)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
