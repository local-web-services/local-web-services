"""When: the event source mapping polls the queue and invokes the Lambda function"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the event source mapping polls the queue and invokes the Lambda function")
def esm_poll_and_invoke(world):
    pytest.skip("Cannot trigger ESM polling in lws")
