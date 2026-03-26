"""Given: the API has received an HTTP request and synchronously invoked the Lambda function"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the API has received an HTTP request and synchronously invoked the Lambda function")
@given('the "API" has received an "HTTP" request and synchronously invoked the Lambda function')
def apigw_lambda_request_received_invoked():
    pytest.skip("Cannot represent a completed API-to-Lambda invocation as sequence setup in lws")
