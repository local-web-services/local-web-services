"""Then: the "sns" "delivery" existed"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "sns" "delivery" existed')
def delivery_is_abandoned_then(world):
    pytest.skip("Cannot observe delivery abandonment in this context")
