"""Given: a synchronous function invocation has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a synchronous function invocation has completed")
def lambda_seq_sync_completed():
    pytest.skip("Cannot trigger Lambda invocation completion in lws")
