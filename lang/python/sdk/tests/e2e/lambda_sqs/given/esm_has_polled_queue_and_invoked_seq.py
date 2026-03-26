"""Given: the event source mapping has polled the queue and invoked the Lambda function"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the event source mapping has polled the queue and invoked the Lambda function")
def esm_has_polled_queue_and_invoked_seq():
    pytest.skip("Cannot trigger ESM polling in lws")
