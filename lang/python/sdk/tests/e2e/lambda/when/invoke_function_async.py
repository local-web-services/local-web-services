"""When: a "lambda" "function" is invoked asynchronously"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "lambda" "function" is invoked asynchronously')
def invoke_function_async(world):
    pytest.skip("Cannot trigger Lambda async invocation in lws without Docker")
