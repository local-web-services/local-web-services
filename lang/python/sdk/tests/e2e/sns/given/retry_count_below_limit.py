"""Given: the retry count was below the limit"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the retry count was below the limit")
def retry_count_below_limit():
    pytest.skip("Cannot control retry count in this context")
