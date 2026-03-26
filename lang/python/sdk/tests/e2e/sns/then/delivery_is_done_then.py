"""Then: the delivery is "DONE" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the delivery is "DONE"')
def delivery_is_done_then(world):
    pytest.skip("Cannot observe delivery completion in this context")
