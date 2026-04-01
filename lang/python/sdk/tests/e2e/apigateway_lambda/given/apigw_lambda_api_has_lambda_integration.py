"""Given: the "api gateway" "API" had a Lambda integration configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "api gateway" "API" had a Lambda integration configured')
def apigw_lambda_api_has_lambda_integration():
    pytest.skip("Cannot configure Lambda integration on REST API in lws")
