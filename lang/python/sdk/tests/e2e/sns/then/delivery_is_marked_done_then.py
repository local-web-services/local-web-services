"""Then: the "sns" "delivery" will be marked "DONE" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "sns" "delivery" will be marked "DONE"')
def delivery_is_marked_done_then(world):
    pytest.skip("Cannot observe delivery completion in this context")
