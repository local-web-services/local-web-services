"""Then: the "api gateway" "request" will be "FAILED" and no "dynamodb" "item" will be written"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "api gateway" "request" will be "FAILED" and no "dynamodb" "item" will be written')
def request_failed_no_item():
    pytest.skip("Cannot simulate DynamoDB write failure via API Gateway in lws")
