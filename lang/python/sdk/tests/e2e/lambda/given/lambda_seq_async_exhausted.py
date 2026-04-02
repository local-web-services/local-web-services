"""Given: a "lambda" "async" invocation exhausts all retries"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "lambda" "async" invocation exhausts all retries')
def lambda_seq_async_exhausted():
    pytest.skip("Cannot trigger Lambda async retry exhaustion in lws")
