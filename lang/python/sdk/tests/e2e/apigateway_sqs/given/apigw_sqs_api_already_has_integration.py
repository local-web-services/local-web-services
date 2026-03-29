"""Given: the "API" already has an integration configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "API" already has an integration configured')
def apigw_sqs_api_already_has_integration():
    pytest.skip("Cannot simulate pre-configured SQS integration conflict in lws")
