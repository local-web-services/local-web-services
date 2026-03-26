"""Then: the delivery is abandoned"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the delivery is abandoned")
def delivery_is_abandoned_then(world):
    pytest.skip("Cannot observe delivery abandonment in integration test context")
