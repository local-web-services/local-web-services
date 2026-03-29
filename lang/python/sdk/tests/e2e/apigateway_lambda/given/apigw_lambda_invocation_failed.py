"""Given: the Lambda invocation has failed and the API has returned an error response"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda invocation has failed and the API has returned an error response")
@given('the Lambda invocation has failed and the "API" has returned an error response')
def apigw_lambda_invocation_failed():
    pytest.skip("Cannot represent a failed Lambda invocation as sequence setup in lws")
