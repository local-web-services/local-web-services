"""Given: the "api gateway" "API" already has a "SNS" integration configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "api gateway" "API" already has a "SNS" integration configured')
def apigw_sns_api_already_has_integration():
    pytest.skip("Cannot simulate pre-configured SNS integration conflict in lws")
