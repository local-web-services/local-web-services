"""Given: the "lambda" "function" invocation fails"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" invocation fails')
def s3api_lambda_invocation_has_failed():
    pytest.skip("Cannot observe internal Lambda invocation failure via public API")
