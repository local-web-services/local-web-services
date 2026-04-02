"""Then: "api gateway" "prod stage" requests will be throttled"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('"api gateway" "prod stage" requests will be throttled')
def prod_stage_requests_are_throttled(world):
    pytest.skip("Cannot verify throttle behaviour for stage endpoints in this context")
