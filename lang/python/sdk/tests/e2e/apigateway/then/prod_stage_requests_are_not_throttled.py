"""Then: prod stage requests are not throttled"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("prod stage requests are not throttled")
def prod_stage_requests_are_not_throttled(world):
    pytest.skip("Cannot verify throttle behaviour for stage endpoints in this context")
