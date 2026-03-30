"""When: a request is made to the throttled dev stage"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a request is made to the throttled dev stage")
def request_to_throttled_dev_stage(world):
    pytest.skip("Cannot simulate HTTP requests to API Gateway stage endpoints in this context")
