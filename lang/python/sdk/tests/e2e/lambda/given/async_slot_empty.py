"""Given: the "lambda" "async" "slot" was empty"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "async" "slot" was empty')
def async_slot_empty():
    pytest.skip("Cannot observe Lambda async slot state in lws")
