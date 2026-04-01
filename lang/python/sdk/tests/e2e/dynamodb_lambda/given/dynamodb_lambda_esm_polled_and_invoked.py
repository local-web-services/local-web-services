"""
Given: the event source mapping has polled the stream and invoked the Lambda function with the
record
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    "the event source mapping has polled the stream and invoked the Lambda function with the record"
)
def dynamodb_lambda_esm_polled_and_invoked():
    pytest.skip("Cannot represent a completed ESM poll and invocation as sequence setup in lws")
