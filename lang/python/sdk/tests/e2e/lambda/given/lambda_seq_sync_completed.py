"""Given: a synchronous "lambda" "function" invocation completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a synchronous "lambda" "function" invocation completes')
def lambda_seq_sync_completed():
    pytest.skip("Cannot trigger Lambda invocation completion in lws")
