"""When: an async invocation succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("an async invocation succeeds")
def process_async_success(world):
    pytest.skip("Cannot trigger Lambda async invocation success in lws")
