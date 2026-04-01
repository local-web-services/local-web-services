"""Given: a failed "lambda" "function" is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a failed "lambda" "function" is deleted')
def lambda_seq_failed_function_deleted():
    pytest.skip("Cannot place Lambda function in FAILED state in lws")
