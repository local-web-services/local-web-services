"""When: a synchronous function invocation completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a synchronous function invocation completes")
def finish_invoke_function_sync(world):
    pytest.skip("Cannot trigger Lambda invocation completion in lws")
