"""Given: the "API" already has a DynamoDB integration configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "API" already has a DynamoDB integration configured')
def apigw_dynamodb_api_already_has_integration():
    pytest.skip("Cannot simulate pre-configured DynamoDB integration conflict in lws")
