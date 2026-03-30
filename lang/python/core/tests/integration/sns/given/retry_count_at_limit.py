"""Given: the retry count is at the limit"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the retry count is at the limit")
def retry_count_at_limit():
    pytest.skip("Cannot control retry count in integration test context")
