"""Given: a function has been invoked synchronously without a concurrency limit"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a function has been invoked synchronously without a concurrency limit")
def lambda_seq_invoked_sync():
    pytest.skip("Cannot trigger Lambda sync invocation in lws without Docker")
