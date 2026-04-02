"""Given: a "lambda" "async" "slot" was "available" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "lambda" "async" "slot" was "available"')
def async_slot_available():
    pytest.skip("Cannot trigger Lambda async invocation in lws")
