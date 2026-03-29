"""When: a function is invoked synchronously within its concurrency limit"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a function is invoked synchronously within its concurrency limit")
def invoke_function_sync_with_concurrency(world):
    pytest.skip("Cannot trigger Lambda sync invocation in lws without Docker")
