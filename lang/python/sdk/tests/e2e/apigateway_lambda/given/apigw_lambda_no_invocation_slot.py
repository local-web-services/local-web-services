"""Given: no invocation slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no invocation slot is available")
def apigw_lambda_no_invocation_slot():
    pytest.skip("Cannot send requests through API Gateway Lambda integration in lws")
