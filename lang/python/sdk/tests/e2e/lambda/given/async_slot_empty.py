"""Given: the async slot is empty"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the async slot is empty")
def async_slot_empty():
    pytest.skip("Cannot observe Lambda async slot state in lws")
