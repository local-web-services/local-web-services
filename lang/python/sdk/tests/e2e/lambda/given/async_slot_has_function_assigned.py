"""Given: the async slot has a function assigned"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the async slot has a function assigned")
def async_slot_has_function_assigned():
    pytest.skip("Cannot observe Lambda async slot state in lws")
