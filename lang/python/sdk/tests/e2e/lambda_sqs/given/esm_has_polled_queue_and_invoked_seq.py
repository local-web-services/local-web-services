"""Given: the event source mapping polls the queue and invokes the "lambda" "function" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the event source mapping polls the queue and invokes the "lambda" "function"')
def esm_has_polled_queue_and_invoked_seq():
    pytest.skip("Cannot trigger ESM polling in lws")
