"""Then: the request will be throttled or pass non-deterministically"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the request will be throttled or pass non-deterministically")
def request_is_throttled_or_passes_non_deterministically(world):
    pytest.skip("Cannot verify throttle behaviour for stage endpoints in this context")
