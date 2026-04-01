"""Given: the "lambda" "function" reads an "ACTIVE" secret and completes successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" reads an "ACTIVE" secret and completes successfully')
def lambda_read_active_secret_succeeded_seq():
    pytest.skip("Cannot trigger Lambda Secrets Manager read in lws")
