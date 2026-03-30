"""Then: the retry count increases"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the retry count increases")
def retry_count_increases(world):
    pytest.skip("Cannot observe retry count in integration tests.")
