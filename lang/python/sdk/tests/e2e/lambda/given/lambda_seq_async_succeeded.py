"""Given: an async invocation succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an async invocation succeeds")
def lambda_seq_async_succeeded():
    pytest.skip("Cannot trigger Lambda async invocation success in lws")
