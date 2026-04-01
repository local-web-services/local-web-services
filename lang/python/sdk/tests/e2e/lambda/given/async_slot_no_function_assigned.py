"""Given: the async slot does not have a "lambda" "function" assigned"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the async slot does not have a "lambda" "function" assigned')
def async_slot_no_function_assigned():
    pytest.skip("Cannot observe Lambda async slot state in lws")
