"""Given: the retry count is below the limit"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the retry count is below the limit")
def retry_count_below_limit():
    pytest.skip("Cannot control retry count in integration test context")
