"""Given: the Lambda function has written an item to the DynamoDB table during invocation"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda function has written an item to the DynamoDB table during invocation")
def lambda_dynamodb_seq_item_written():
    pytest.skip("Cannot trigger Lambda invocation in lws")
