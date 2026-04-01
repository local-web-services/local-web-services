"""Given: the "api gateway" "API" had no integration configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "api gateway" "API" already had an "api gateway" "integration" configured')
def apigw_sqs_api_already_has_integration():
    pytest.skip("Cannot simulate pre-configured SQS integration conflict in lws")
