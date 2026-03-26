"""When: a delivery retry is exhausted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a delivery retry is exhausted")
def delivery_retry_exhausted(world):
    pytest.skip("Cannot exhaust delivery retries in this context")
