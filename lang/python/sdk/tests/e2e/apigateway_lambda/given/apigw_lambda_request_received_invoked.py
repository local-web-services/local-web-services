"""Given: the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"'
)
@given(
    'the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"'
)
def apigw_lambda_request_received_invoked():
    pytest.skip("Cannot represent a completed API-to-Lambda invocation as sequence setup in lws")
