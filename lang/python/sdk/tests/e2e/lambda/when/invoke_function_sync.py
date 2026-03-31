"""When: a "lambda" "function" is invoked synchronously without a concurrency limit"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "lambda" "function" is invoked synchronously without a concurrency limit')
def invoke_function_sync(world):
    pytest.skip("Cannot trigger Lambda sync invocation in lws without Docker")
