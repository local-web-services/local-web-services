"""Then: the "lambda" "function" async event will be dropped and the "async" "slot" will be freed"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "lambda" "function" async event will be dropped and the "async" "slot" will be freed')
def event_dropped_and_slot_freed(world):
    pytest.skip("Cannot observe Lambda async slot state in lws")
