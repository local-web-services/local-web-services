"""When: a "lambda" "async" invocation fails and is retried"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "lambda" "async" invocation fails and is retried')
def process_async_retry(world):
    pytest.skip("Cannot trigger Lambda async retry in lws")
