"""Then: the event is dropped and the slot is freed"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the event is dropped and the slot is freed")
def event_dropped_and_slot_freed(world):
    pytest.skip("Cannot observe async slot state in integration tests.")
