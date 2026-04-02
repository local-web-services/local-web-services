"""Given: a "lambda" "async" invocation fails and is retried"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "lambda" "async" invocation fails and is retried')
def lambda_seq_async_retried():
    pytest.skip("Cannot trigger Lambda async retry in lws")
