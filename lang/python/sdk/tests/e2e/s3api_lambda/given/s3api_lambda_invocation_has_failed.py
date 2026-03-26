"""Given: the Lambda invocation has failed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda invocation has failed")
def s3api_lambda_invocation_has_failed():
    pytest.skip("Cannot observe internal Lambda invocation failure via public API")
