"""Given: the Lambda invocation fails"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda invocation fails")
def s3api_lambda_invocation_has_failed():
    pytest.skip("Cannot observe internal Lambda invocation failure via public API")
