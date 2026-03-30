"""When: a delivery attempt fails and is retried"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a delivery attempt fails and is retried")
def delivery_fails_and_retried(world):
    pytest.skip("Cannot trigger delivery failure and retry in integration test context")
