"""Given: a "lambda" "function" is invoked synchronously within its concurrency limit"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "lambda" "function" is invoked synchronously within its concurrency limit')
def lambda_seq_invoked_sync_concurrency():
    pytest.skip("Cannot trigger Lambda sync invocation in lws without Docker")
