"""Given: the Lambda invocation has completed successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda invocation has completed successfully")
def s3api_lambda_invocation_completed_successfully():
    pytest.skip("Cannot observe internal Lambda invocation completion via public API")
