"""Given: the "lambda" "function" invocation processes the "dynamodb" "stream" record successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" invocation processes the "dynamodb" "stream" record successfully')
def dynamodb_lambda_invocation_success():
    pytest.skip("Cannot represent a completed Lambda invocation as sequence setup in lws")
