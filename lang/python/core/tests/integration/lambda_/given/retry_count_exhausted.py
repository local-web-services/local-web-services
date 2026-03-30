"""Given: the retry count has been exhausted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the retry count has been exhausted")
def retry_count_exhausted(world):
    pytest.skip("Cannot exhaust retry count in integration tests.")
