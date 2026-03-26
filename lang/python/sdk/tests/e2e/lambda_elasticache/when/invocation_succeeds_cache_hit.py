"""When: the Lambda invocation reads an existing cache entry and completes successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda invocation reads an existing cache entry and completes successfully")
def invocation_succeeds_cache_hit(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
