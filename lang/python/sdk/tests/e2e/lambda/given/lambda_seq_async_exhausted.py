"""Given: an async invocation has exhausted all retries"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an async invocation has exhausted all retries")
def lambda_seq_async_exhausted():
    pytest.skip("Cannot trigger Lambda async retry exhaustion in lws")
