"""When: the Lambda function writes an item to the DynamoDB table during invocation"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda function writes an item to the DynamoDB table during invocation")
def lambda_writes_item(world):
    pytest.skip("Cannot trigger Lambda item write in lws")
