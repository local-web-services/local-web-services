"""Then: the "lambda" "async" "slot" will be freed"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "lambda" "async" "slot" will be freed')
def async_slot_freed(world):
    pytest.skip("Cannot observe Lambda async slot state in lws")
