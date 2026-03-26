"""Given: the async slot is occupied"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the async slot is occupied")
def async_slot_occupied():
    pytest.skip("Cannot observe Lambda async slot state in lws")
