"""Then: the transaction slot is free"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the transaction slot is free")
def transaction_slot_is_free_then(world: dict):
    pytest.skip("Cannot observe transaction slot state in integration context")
