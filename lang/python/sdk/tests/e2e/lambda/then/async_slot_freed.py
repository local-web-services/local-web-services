"""Then: the async slot is freed"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the async slot is freed")
def async_slot_freed(world):
    pytest.skip("Cannot observe Lambda async slot state in lws")
