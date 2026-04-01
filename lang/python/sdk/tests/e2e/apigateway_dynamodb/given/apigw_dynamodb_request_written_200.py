"""
Given: a request has been received, the API has written to the DynamoDB table, and returned 200
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200'
)
@given(
    'a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200'
)
def apigw_dynamodb_request_written_200():
    pytest.skip("Cannot represent a completed API-to-DynamoDB request as sequence setup in lws")
