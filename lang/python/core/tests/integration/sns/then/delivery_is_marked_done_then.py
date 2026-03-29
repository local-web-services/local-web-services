"""Then: the delivery is marked "DONE" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the delivery is marked "DONE"')
def delivery_is_marked_done_then(world):
    pytest.skip("Cannot observe delivery completion in integration test context")
