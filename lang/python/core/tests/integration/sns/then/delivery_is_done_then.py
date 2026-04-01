"""Then: the "sns" "delivery" will be "DONE" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "sns" "delivery" will be "DONE"')
def delivery_is_done_then(world):
    pytest.skip("Cannot observe delivery completion in integration test context")
