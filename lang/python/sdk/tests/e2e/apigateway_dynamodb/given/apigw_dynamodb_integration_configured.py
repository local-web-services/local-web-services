"""Given: a direct "dynamodb" integration is configured on the "api gateway" "API" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a direct "dynamodb" integration is configured on the "api gateway" "API"')
@given('a direct "dynamodb" integration is configured on the "api gateway" "API"')
def apigw_dynamodb_integration_configured():
    pytest.skip(
        "Cannot configure DynamoDB integration and issue full request for sequence setup in lws"
    )
