"""
Given: a request has been received but the DynamoDB write has failed because the table is being
deleted
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    "a request has been received but the DynamoDB write has failed because the table is being deleted"  # noqa: E501
)
def apigw_dynamodb_request_write_failed():
    pytest.skip("Cannot represent a failed DynamoDB write as sequence setup in lws")
