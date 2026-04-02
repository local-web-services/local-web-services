"""When: a "lambda" "async" invocation exhausts all retries"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "lambda" "async" invocation exhausts all retries')
def process_async_exhausted(world):
    pytest.skip("Cannot trigger Lambda async retry exhaustion in lws")
