"""When: all delivery retries are exhausted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("all delivery retries are exhausted")
def all_delivery_retries_exhausted(world):
    pytest.skip("Cannot exhaust all delivery retries in this context")
