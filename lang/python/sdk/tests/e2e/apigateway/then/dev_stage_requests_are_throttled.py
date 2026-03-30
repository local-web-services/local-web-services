"""Then: dev stage requests are throttled"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("dev stage requests are throttled")
def dev_stage_requests_are_throttled(world):
    pytest.skip("Cannot verify throttle behaviour for stage endpoints in this context")
