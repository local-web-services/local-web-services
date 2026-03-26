"""When: the Lambda invocation fails because all cache entries have been evicted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda invocation fails because all cache entries have been evicted")
def invocation_fails_cache_miss(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
